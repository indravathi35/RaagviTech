import { LightningElement,api,track,wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import accountRelatedObjects1 from '@salesforce/apex/MapAccConOppProdPrice.accountRelatedObjects1';
const columns=[
  {
    fieldName: 'Accounturl',
    label: 'Name',
    type: 'url',
    typeAttributes: {
      label: { fieldName: 'Name' },
    },
  },
   {
  fieldName: 'Phone',
    label: 'Phone',
    typeAttributes: {
      label: { fieldName: 'Phone' },
      tooltip: { fieldName: 'Phone' },
    },
  }
];
export default class AccConOppProPrice extends NavigationMixin( LightningElement ) {
    
    gridData;
    @track gridColumns =columns ;
    @wire(accountRelatedObjects1)
  wiredAccounts({ error, data }) {
    if (data) {
    this.gridData=this.FetchData(data);
           
    }
    else if (error) {
      this.error = error;
      this.accounts = undefined;
    }
  }
  FetchData(result){
    return result.accountList
    .filter(a => result.ContactMap[a.Id])
    .map(a => ({
      Id: a.Id,
      Name: a.Name,
      Phone:a.Phone,
      Accounturl:'/'+a.Id,
      _children: this.FetchContacts(a.Id, result)
  }));
  }
  FetchContacts(acId,result){
    return result.ContactMap[acId]

    .map(c => ({
      Id:c.Id,
      Name:c.LastName,
      Phone:c.Phone,
      Accounturl:'/'+c.Id,
      _children: this.FetchOpportunities(c.Id,acId,result)
    }));
  }
  FetchOpportunities(conId,accId,result){
    //console.log('oppp---',JSON.stringify(result));
    
    const opportunities = result.oppMap[accId];
    
    if (opportunities && opportunities.length > 0)
    {
      return opportunities.filter(opportunity => opportunity.Contactopp__c === conId)
      .map(opportunity => ({
          Id: opportunity.Id,
          Name: opportunity.Name,
          Accounturl:'/'+opportunity.Id,
          _children: this.FetchProducts(accId,opportunity.Id, result)
      }));
  }
  return [];
  }
  FetchProducts(acccId,opId,result){
    return result.ProductMap[acccId].filter(p => p.Opportunity__c === opId)
    .map(p =>({
      Id:p.Id,
      Name:p.Name,
     //Phone:p.phone__c,
     Accounturl:'/'+p.Id,
      _children:this.FetchPriceBooks(acccId,p.Id,result)
    }));
  }
    FetchPriceBooks(accccId,prId,result){
      return result.PriceMap[accccId]
      .filter(p => p.Product__c === prId)
      .map(pr =>({
        Id:pr.Id,
        Name:pr.Name,
        //Phone:pr.phone__c,
        Accounturl:'/'+pr.Id,
      }));
    }

  
}

