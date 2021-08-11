namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
   if Rails.env.development?
    show_spinner("Apagando BD...") { %x(rails db:drop) }
    show_spinner("Criando BD...") { %x(rails db:create) }
    show_spinner("Migrando BD...") { %x(rails db:migrate) }
    %x(rails dev:add_coins)
    %x(rails dev:add_mining_types)
  else
    puts "Você não está em ambiente de desenvolvimento!"
   end   
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
                {
                  description: "Bitcoin",
                  acronym: "BTC",
                  url_image: "http://pngimg.com/uploads/bitcoin/small/bitcoin_PNG47.png" 
                },
                {
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://cdn.freelogovectors.net/wp-content/uploads/2020/03/ethereum-logo.png"
                },
                {
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://assets.coingecko.com/coins/images/297/large/dashcoin.png?1547034071"
                }    
              ]
      
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {name: "Proof of Work", acronym: "PoW"},
        {name: "Proof of Stake", acronym: "PoS"},
        {name: "Proof of Capacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
