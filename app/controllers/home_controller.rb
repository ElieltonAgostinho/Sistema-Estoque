class HomeController < ApplicationController
  require 'csv'
  def index
    render :index
  end

  def create
    uploaded_io = params[:file]
    File.open('public/uploads/'+uploaded_io.original_filename, 'wb') do |file|
      file.write(uploaded_io.read)
    end
    $r = ''
    #puts uploaded_io.original_filename
    CSV.foreach('public/uploads/'+uploaded_io.original_filename, col_sep: ';', encoding: "ISO8859-1").with_index do |linha, indice|

      begin

        if indice > 0 then
          $r += '<div class="alert alert-warning" role="alert">'
          $r += movimentacao(linha)
          $r += '</div>'

        end
      rescue => e
        $r += 'Error: '+e.message
      end


    end
    @retorno = $r.html_safe

    render :'home/index'

  end

  def movimentacao(linha)
    
    @local = linha[0]
    @data = linha[1]
    @tipo = linha[2]
    @produto = linha[3]
    @quantidade = linha[4]
    puts @produto

    if (@local.nil? == true || @local == '') then
      return 'Error: Campo Local do produto '+@produto.to_s+' está vazio.'
    end

    if (@produto.nil? == true || @produto == '') then
      return 'Error: Campo Produto '+@produto.to_s+' está vazio.'
    end
    #puts @local
    @idLocalArm = verificaLocal(@local)
    @idProduto = verificaProduto(@produto)
    #puts @idLocalArm,@idProduto

    if (@quantidade.nil? == true || @quantidade == '') then
      return 'Error: Campo Quantidade do produto '+@produto.to_s+' está vazio.'
    end
    @date = nil
    if (@data.nil? == true || @data == '') then
      return 'Error: Campo Quantidade do produto '+@produto.to_s+' está vazio.'
    else
      @data.split('/')
      @date = @data[2]+'-'+@data[1]+'-'+@data[0]
      
    end
    
      dt = @data.split('/')
      @date = dt[2]+'-'+dt[1]+'-'+dt[0]
    
     if (Date.parse('2021-01-01') > Date.parse(@date)) || (Date.parse('2021-01-31') < Date.parse(@date))
        
      return 'Data para movimentação é inválida!'
        
      end 

    if @tipo == 'E' then

      @cadMoviment = Movimentacao.create(:produtos_id => @idProduto,:local_armazenamentos_id => @idLocalArm,
                                         :tipo => @tipo,:data => @date,:quantidade => @quantidade)
      if @cadMoviment.save then
        adicionaEstoque(@idProduto,@quantidade,@idLocalArm)
        @qtd = consultaEstoque(@idProduto,@idLocalArm)
        return 'Existe '+@qtd.to_s+' do produto '+@produto.to_s+' no local '+@local.to_s+' com a adição do dia '+@data.to_s
      else
        return 'Não foi possível cadastrar o produto '+@produto.to_s+'!'
      end

    else
      if @tipo == 'S' then
        @ret = removerEstoque(@idProduto,@quantidade,@idLocalArm)

        if @ret == false then
          return 'O produto '+@produto.to_s+' não está disponível para retirada no local '+@local.to_s
        else
          if @ret == true
            return 'Retirada de '+@quantidade.to_s+' do produto '+@produto.to_s+' no local '+@local.to_s+' dia '+@data.to_s+' realizado com sucesso!'
          else
            return 'A quantidade do produto '+@produto.to_s+' é maior do que a quantidade em estoque no local '+@local.to_s 
          end
          
        end

      else
        return 'Error: Não foi possível verificar se o produto '+@produto.to_s+' é entrada ou saída.'
      end
    end


    puts 'ID_Local:'+@idLocalArm.to_s,'ID_Produto:'+@idProduto.to_s
  end

  def verificaLocal(local)
    puts local
    @localErro = false
    @cadastrarMovimentacao = false

    @query = LocalArmazenamento.find_by nome: local 

    if @query.nil? == false
      puts 'Cadastrar Movimentação'
      return @query.id
    else
      @localArm = LocalArmazenamento.create(:nome => local)

        if @localArm.save then
          puts 'Novo Local Cadastrado!'
          @cadastrarMovimentacao = true
        else
          puts 'Erro ao cadastrar local'
          @localErro = true
        end
    end

    if @cadastrarMovimentacao == true then
      LocalArmazenamento.find do |cl|
        if cl.nome == local then
          return cl.id
        end
      end
    end


  end

  def verificaProduto(produto)
    @produtoErro = false
    @cadastrarMovimentacao = false
    @queryP = Produto.find_by nome: produto
      if @queryP.nil? == false then
        puts 'Cadastrar Movimentação'
        return @queryP.id
      else
        @produtoArm = Produto.create(:nome => produto)

        if @produtoArm.save then
          puts 'Novo Produto Cadastrado!'
          @cadastrarMovimentacao = true
        else
          puts 'Erro ao cadastrar Produto'
          @produtoErro = true
        end

      end
    
    if @cadastrarMovimentacao == true then
      Produto.find do |cl|
        if cl.nome == produto then
          return cl.id
        end
      end
    end


  end

  def consultaEstoque(produto,local)
    @queryEst = Estoque.find_by produtos_id: produto, local_armazenamentos_id: local

    return @queryEst.quantidade
  end

  def adicionaEstoque(produto,quantidade,local)

    @queryE = Estoque.find_by produtos_id: produto, local_armazenamentos_id: local

    if @queryE.nil? == true
      Estoque.create(:produtos_id => produto,:local_armazenamentos_id => local,:quantidade => quantidade)
    else
      @queryE.quantidade = @queryE.quantidade + quantidade.to_i
      @queryE.save
    end

    
  end

  def removerEstoque(produto,quantidade,local)

    @queryE = Estoque.find_by produtos_id: produto, local_armazenamentos_id: local
    #puts @queryE.quantidade
    if @queryE.nil? == false then
      #Tem estoque

      if @queryE.quantidade < quantidade.to_i #Se quantidade exigida for maior que a quantidade em estoque não remove
        return 0
      else
        @queryE.quantidade = @queryE.quantidade - quantidade.to_i
        @queryE.save
        return true
      end
      
    else
      #Não tem estoque
      return false
    end

    
  end


end
