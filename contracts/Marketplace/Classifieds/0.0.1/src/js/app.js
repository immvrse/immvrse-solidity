App = {
     web3Provider: null,
     contracts: {},
     account: 0x0,

     init: function() {

          return App.initWeb3();
     },

     initWeb3: function() {
          //initialize web3
          if(typeof web3 !== 'undefined'){
            //reuse provider of Web3 object injected by Metamask
            App.web3Provider = web3.currentProvider;
          }else
            {
              //create a new provider and plug it directly into our local nodes
              App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
            }
          web3 =new Web3(App.web3Provider);

          App.displayAccountInfo();

          return App.initContract();
     },

     displayAccountInfo: function() {
       web3.eth.getCoinbase(function(err,account){
         if(err === null){
           App.account = account;
           $('#account').text(account);
           web3.eth.getBalance(account, function(err, balance) {
             if(err === null){
               $('#accountBalance').text(web3.fromWei(balance, "ether") + "ETH");
             }
             })
           }
         });
       },


     initContract: function() {
        $.getJSON('Classifieds.json', function (classifiedsArtifact){
          //get the contract artifact file and use it to instantiate a truffle contract abstraction
          App.contracts.Classifieds = TruffleContract(classifiedsArtifact);
          //set the provider for the contracts
          App.contracts.Classifieds.setProvider(App.web3Provider);

        //listen to events
        App.listentoEvents();
          //retrieve the article from the contract
          return App.reloadArticles()
        });
     },
     reloadArticles: function(){
       //refresh account info because the balance might have changed
       App.displayAccountInfo();

       //retrieve the article placeholder and clear it
       $('#articlesRow').empty();

       App.contracts.Classifieds.deployed().then(function(instance){
         return instance.getArticle();
       }).then(function(article){
         if(article[0] == 0x0){
           //no article
           return;
         }

         //retrieve the article template and fill interval
         var articleTemplate = $('#articleTemplate');
         articleTemplate.find('.panel-title').text(article[1]);
         articleTemplate.find('.article-description').text(article[2]);
         articleTemplate.find('.article-price').text(web3.fromWei(article[3],"ether"));

         var seller =article[0];
         if (seller == App.account){
           seller = "You";
         }
         articleTemplate.find('.article-seller').text(seller);

        //add this articlesRow
        $('#articlesRow').append(articleTemplate.html());
      }).catch(function(err){
        console.error(err.message);
       });

     },

     sellArticle: function(){
       //retrieve the detail of the articles
       var _article_name = $('#article_name').val();
       var _description = $('#article_description').val();
       var _price = web3.toWei(parseFloat($('#article_price').val()||0),"ether");


      if((_article_name.trim()=='') || (_price == 0)){
        //nothing to sell
        return false;
      }
      App.contracts.Classifieds.deployed().then (function(instance){
        return instance.sellArticle(_article_name, _description, _price,{
          from: App.account,
          gas: 500000
        });
      }).then(function(result)
    {

    }).catch(function(err){
      console.error(err);
    });
  },
//listen to events triggered by contracts

  listentoEvents: function(){
    App.contracts.Classifieds.deployed().then(function(instance){
      instance.LogSellArticle({},{}).watch(function(error,event){
        if(!error){
          $("#events").append('<li class="list-group-item">'+ event.args._name + ' is now for sale</li>');
        }else{
          console.error(error);
        }
        App.reloadArticles();
      })
    });
  }
};

$(function() {
     $(window).load(function() {
          App.init();
     });
});
