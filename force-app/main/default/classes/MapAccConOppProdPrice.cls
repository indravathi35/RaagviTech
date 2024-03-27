/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* appex Class to map account with contacts related acccounts,opportunities related contacts,products related opportunities,pricebooks related products.
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         sanati indravathi      <indravathi.sanati@raagvitech.com>
* @modifiedBy     sanati indravathi      <indravathi.sanati@raagvitech.com>
* @maintainedBy   sanati indravathi      <indravathi.sanati@raagvitech.com>
* @version        59.0
* @created        2024-02-16
* @modified       
* @systemLayer    Aerial_Image_v1_Cls_API
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘ 
**/
public with sharing class MapAccConOppProdPrice {
    /**    
   * ───────────────────────────────────────────────────────────────────────────────────────────────────┐
   * @description getting contacts related acccounts,opportunities related contacts,products related opportunities,pricebooks related products.
   * ───────────────────────────────────────────────────────────────────────────────────────────────────
   * @param   Non
   * @return   wrapper class
   * ───────────────────────────────────────────────────────────────────────────────────────────────────┘
   **/
  /*@AuraEnabled(cacheable=true)
    public static wrapper MapAccConOppProdPrice() {
        wrapper wrp = new wrapper();
        map<Id,List<Contact>> accountContactMap = new map<id,List<Contact>>();
        map<Id,List<Opportunity>> accountoppMap=new map<id,List<Opportunity>>();
        map<Id,List<Product2>> accountProductMap=new map<id,List<Product2>>();
        map<Id,List<Pricebook2>> accountPriceMap=new map<id,List<Pricebook2>>();
        Set<Id> accIds=new Set<Id>();
       List<Account> lstAccount = [SELECT Id, name,phone FROM Account];
       List<Contact> conList=[SELECT Id, name,phone,AccountId FROM Contact WHERE AccountId In: lstAccount  ];
       List<Opportunity> oppList=[SELECT Id, Name,phone__c,Contactopp__c,Contactopp__r.AccountId FROM Opportunity WHERE Contactopp__c In: conList  ];
       List<Product2> proList=[SELECT Id, name,phone__c,Opportunity__c,Opportunity__r.Contactopp__r.AccountId FROM Product2 WHERE Opportunity__c In: oppList ];
       List<Pricebook2> pricebooklist=[SELECT Id,name,phone__c,Product__c,Product__r.Opportunity__r.Contactopp__r.AccountId FROM Pricebook2 WHERE  Product__c In: proList  ];

     for(Contact con : conList){

        if(!accountContactMap.containsKey(con.AccountId)){

            accountContactMap.put(con.AccountId,new List<Contact>());
        }
        accountContactMap.get(con.AccountId).add(con);

     }

     for(Opportunity opp : oppList){

        if(!accountContactMap.containsKey(opp.Contactopp__c)){

            accountoppMap.put(opp.Contactopp__r.AccountId,new List<Opportunity>());
        }
        accountoppMap.get(opp.Contactopp__r.AccountId).add(opp);

     }
     for(Product2 pro : proList){

        if(!accountProductMap.containsKey(pro.Opportunity__c)){

            accountProductMap.put(pro.Opportunity__r.Contactopp__r.AccountId,new List<Product2>());
        }
        accountProductMap.get(pro.Opportunity__r.Contactopp__r.AccountId).add(pro);

     }
     for(Pricebook2 book : pricebooklist){

        if(!accountPriceMap.containsKey(book.Product__c)){

            accountPriceMap.put(book.Product__r.Opportunity__r.Contactopp__r.AccountId,new List<Pricebook2>());
        }
        accountPriceMap.get(book.Product__r.Opportunity__r.Contactopp__r.AccountId).add(book);

     }
      wrp.ContactMap=accountContactMap;
      //System.debug('con--'+wrp.ContactMap);
      wrp.oppMap=accountoppMap;
      System.debug('opp--'+wrp.oppMap);
      wrp.ProductMap=accountProductMap;
      //System.debug('pro--'+wrp.ProductMap);
      wrp.PriceMap=accountPriceMap;
      wrp.accountList=lstAccount;
       //System.debug('price-'+wrp.PriceMap);
       //System.debug('dataa--'+wrp);
       return wrp;
    }
    
    public class wrapper{
        @AuraEnabled
        public List<Account> accountList;
        @AuraEnabled
        public map<Id,List<Contact>> ContactMap;
        @AuraEnabled
        public map<Id,List<Opportunity>> oppMap;
        @AuraEnabled
        public map<Id,List<Product2>> ProductMap;
        @AuraEnabled
        public map<Id,List<Pricebook2>> PriceMap;
          
       } */
        @AuraEnabled(Cacheable=true)
        public static Wrapper accountRelatedObjects1(){
           Wrapper wrap = new Wrapper();
           Map<String,String>mapofcontactswithAccIds = new  Map<String,String>();
           Map<String,String>mapofOppwithAccIds = new  Map<String,String>();
           Map<String,String>mapofproductwithAccIds = new  Map<String,String>();
            List<Account> account = new List<Account>();
           Map<Id, List<Contact>> accandCon = new Map<Id, List<Contact>>();
           map<Id,list<Opportunity>> accandOpp = new map<Id,list<Opportunity>>();
           map<Id,list<Product2>> accandProd = new map<Id,list<Product2>>();
           map<Id,list<Pricebook2>> accandPrice = new map<Id,list<Pricebook2>>();
           
           List<Account> accounts = [SELECT Id, Name,Phone,Email__c,CreatedDate FROM Account ];
           For(Account acc:accounts){
            account.add(acc);
           }
           List<Contact> contacts = [SELECT Id, FirstName, LastName,Phone, AccountId FROM Contact WHERE AccountId IN :accounts];
           for (Contact con : contacts) {
               if (!accandCon.containsKey(con.AccountId)) {
                   accandCon.put(con.AccountId, new List<Contact>());
               }
               accandCon.get(con.AccountId).add(con);
               mapofcontactswithAccIds.put(con.Id,con.AccountId);  
           }
           List<Opportunity> opps = [SELECT Id, Name,phone__c,Contactopp__r.AccountId, Contactopp__c  FROM Opportunity WHERE Contactopp__c IN : contacts ];
           for(Opportunity opp:opps){
               String accountId = mapofcontactswithAccIds.get(opp.Contactopp__c);
               if (!accandOpp.containsKey(accountId)) {
                   accandOpp.put(accountId, new List<Opportunity>());
               }
               accandOpp.get(accountId).add(opp);
               mapofOppwithAccIds.put(opp.Id,accountId);
           }
           List<Product2> pro =[SELECT Id, Name,phone__c, ProductCode, Opportunity__c FROM Product2 WHERE Opportunity__c IN :opps];
           for(Product2 product : pro){
               String accountId1 = mapofOppwithAccIds.get(product.Opportunity__c);
               if(!accandProd.containsKey(accountId1)){
                   accandProd.put(accountId1,new List<Product2>());
               }
               accandProd.get(accountId1).add(product);
               mapofproductwithAccIds.put(product.Id,accountId1);
           }
            List<Pricebook2> price = [SELECT Id, Name,phone__c, Product__c FROM Pricebook2 WHERE Product__c IN :pro];
           for(Pricebook2 pricebook : price){
               String accountId2 = mapofproductwithAccIds.get(pricebook.Product__c);
               if(!accandPrice.containsKey(accountId2)){
                   accandPrice.put(accountId2, new List<Pricebook2>());
               }
               accandPrice.get(accountId2).add(pricebook);            
           }
           System.debug('account Contact:'+accandCon);
           System.debug('account opportunities:'+accandOpp);
           System.debug('account Products:'+accandProd);
           System.debug('account PriceBooks:'+accandPrice); 
           wrap.accountList = account;
           wrap.ContactMap = accandCon;
           wrap.oppMap = accandOpp;
           wrap.ProductMap = accandProd;
           wrap.PriceMap= accandPrice;
           
           return wrap;
       }
       public class Wrapper {
        @AuraEnabled
        public List<Account> accountList{get;set;}
        @AuraEnabled
        public Map<Id, List<Contact>> ContactMap{ get; set; }
        @AuraEnabled
        public Map<Id, List<Opportunity>> oppMap { get; set; }
        @AuraEnabled
        public Map<Id, List<Product2>> ProductMap{ get; set; }
        @AuraEnabled
        public Map<Id, List<Pricebook2>> PriceMap { get; set; }
    }
       
      /* public static void accountRelatedObjects(){
          // Wrapper wrap = new Wrapper();
           Map<String,String>mapofcontactswithAccIds = new  Map<String,String>();
           Map<String,String>mapofOppwithAccIds = new  Map<String,String>();
           Map<String,String>mapofproductwithAccIds = new  Map<String,String>();
           
           Map<Id, List<Contact>> accandCon = new Map<Id, List<Contact>>();
           map<Id,list<Opportunity>> accandOpp = new map<Id,list<Opportunity>>();
           map<Id,list<Product2>> accandProd = new map<Id,list<Product2>>();
           map<Id,list<Pricebook2>> accandPrice = new map<Id,list<Pricebook2>>();
           
           List<Account> accounts = [SELECT Id, Name FROM Account];
           List<Contact> contacts = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE AccountId IN :accounts];
           for (Contact con : contacts) {
               if (!accandCon.containsKey(con.AccountId)) {
                   accandCon.put(con.AccountId, new List<Contact>());
               }
               accandCon.get(con.AccountId).add(con);
               mapofcontactswithAccIds.put(con.Id,con.AccountId);  
           }
           List<Opportunity> opps = [SELECT Id, Name, Contact__c,Contact__r.AccountId  FROM Opportunity WHERE Contact__c IN : contacts ];
           for(Opportunity opp:opps){
               // here in the get(key) method if we give key means it will give the key related value means it will give accountID
               String accountId = mapofcontactswithAccIds.get(opp.Contact__c);
               if (!accandOpp.containsKey(mapofcontactswithAccIds.get(opp.Contact__c))) {
                   accandOpp.put(mapofcontactswithAccIds.get(opp.Contact__c), new List<Opportunity>());
               }
               accandOpp.get(mapofcontactswithAccIds.get(opp.Contact__c)).add(opp);
               //mapofOppwithAccIds.put(opp.Id,opp.Contact__r.AccountId);
              // mapofOppwithAccIds.put(opp.Id,opp.Contact__c);
               mapofOppwithAccIds.put(opp.Id,accountId);
           }
           System.debug('mapofOppwithAccIds===='+mapofOppwithAccIds);
           List<Product2> pro =[SELECT Id, Name, ProductCode, Opportunity__c,Opportunity__r.Contact__r.AccountId FROM Product2 WHERE Opportunity__c IN :opps];
           //String acc = mapofOppwithAccIds.get();
           for(Product2 product : pro){
               
               String accountId1 = mapofOppwithAccIds.get(product.Opportunity__c);
               System.debug('account id product==='+accountId1);
               if(!accandProd.containsKey(mapofOppwithAccIds.get(product.Opportunity__c))){
                   accandProd.put(accountId1,new List<Product2>());
               }
               accandProd.get(accountId1).add(product);
               mapofproductwithAccIds.put(product.Id,product.Opportunity__r.Contact__r.AccountId);
           }
            List<Pricebook2> price = [SELECT Id, Name, Product__c FROM Pricebook2 WHERE Product__c IN :pro];
           for(Pricebook2 pricebook : price){
               String accountId2 = mapofproductwithAccIds.get(pricebook.Product__c);
               if(!accandPrice.containsKey(accountId2)){
                   accandPrice.put(accountId2, new List<Pricebook2>());
               }
               accandPrice.get(accountId2).add(pricebook);            
           }
           System.debug('account Contact:'+accandCon);
           System.debug('account opportunities:'+accandOpp);
           System.debug('account Products:'+accandProd);
           System.debug('account PriceBooks:'+accandPrice); 
           
           //wrap.conWrap = accandCon;
           //wrap.oppWrap = accandOpp;
           //wrap.proWrap = accandProd;
           //wrap.priceWrap = accandPrice;
           
           //return wrap;
       }*/
    
}