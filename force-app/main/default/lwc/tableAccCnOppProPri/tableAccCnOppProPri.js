import { LightningElement ,wire,api} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import updateAccounts from '@salesforce/apex/InlineEditing.updateAccounts';
import updateOpportunities from '@salesforce/apex/InlineEditing.updateOpportunities';
import updateContacts from '@salesforce/apex/InlineEditing.updateContacts';
import updateProducts from '@salesforce/apex/InlineEditing.updateProducts';
import updatePriceBooks from '@salesforce/apex/InlineEditing.updatePriceBooks';
import accountRelatedObjects1 from '@salesforce/apex/MapAccConOppProdPrice.accountRelatedObjects1';
export default class TableAccCnOppProPri extends NavigationMixin(LightningElement) {
    result;
    @api accountId;
    accs;
    opMap;
    proMap;
    priMap;
    conMap;
    acId;
    conId;
    oppId;
    productId;
    priceId;
    SaveAll=false;
    cancel;
    currentPage = 1;
    pageSize = 5;
    displayedaccs
    searchTerm = '';
    dummyaccs;
    view=false;
    selectedRows=[];
    @api selectedAccountDetails = [];
    expor=false;
    comp2=false;
    @wire(accountRelatedObjects1)
  async wiredAccounts({ error, data }) {
    if (data) {
      this.result=data;
    console.log('result---',JSON.stringify(this.result));
    this.conMap=this.result.ContactMap;
    this.opMap=this.result.oppMap;
    this.proMap= this.result.ProductMap;
    this.priMap= this.result.PriceMap;
    this.accs=this.result.accountList.filter(a => this.result.ContactMap[a.Id]);
    this.fetchData();
     this.getData();
   console.log('accs--',JSON.stringify(this.accs));
    }
    else if (error) {
      this.error = error;
    }
  }
  fetchData(){
   var filterAcc = [];
   
      for (let i = 0; i < this.accs.length; i++) {
        let Contacts = [];
        var filterCon=[];
        for(let j = 0; j < this.conMap[this.accs[i].Id].length; j++){
            Contacts.push(this.conMap[this.accs[i].Id][j]);
            let Opportunities=[];
            var filterOpp=[];
            for( let key in this.opMap){
                if(key===this.accs[i].Id){
                    for( let k=0;k< this.opMap[this.accs[i].Id].length;k++){

                    if(this.conMap[this.accs[i].Id][j].Id === this.opMap[this.accs[i].Id][k].Contactopp__c){
                        
                        let currentOpportunity = this.opMap[this.accs[i].Id][k];
                        Opportunities.push(currentOpportunity);
                    let Products=[];
                    var filterProd=[];
                    for(let key in this.proMap){
                        if(key=== this.accs[i].Id){
                            for(let l=0;l< this.proMap[this.accs[i].Id].length;l++){
                                if(this.proMap[this.accs[i].Id][l].Opportunity__c===this.opMap[this.accs[i].Id][k].Id){
                                    Products.push(this.proMap[this.accs[i].Id][l]);
                                    let PriceBooks=[];
                                    for(let key in this.priMap){
                                        if(key=== this.accs[i].Id){
                                            for(let m=0;m< this.priMap[this.accs[i].Id].length;m++){
                                                if(this.priMap[this.accs[i].Id][m].Product__c=== this.proMap[this.accs[i].Id][l].Id){
                                                    PriceBooks.push(this.priMap[this.accs[i].Id][m]);
                                                   
                                                }
                                            }
                                        }    
                                    }
                    let obj4 = {};
                    obj4.Id=this.proMap[this.accs[i].Id][l].Id;
                    obj4.Name = this.proMap[this.accs[i].Id][l].Name;
                    obj4.Phone =this.proMap[this.accs[i].Id][l].phone__c;
                    if(PriceBooks.length>0){
                    obj4.PriceBooks=PriceBooks;
                    }
                    filterProd.push(obj4);
                                }
                    
                            }
                        }
                    }
                    Products=filterProd;
                    let obj3 = {};
                    obj3.Id=this.opMap[this.accs[i].Id][k].Id;
                    obj3.Name = this.opMap[this.accs[i].Id][k].Name;
                    obj3.Phone =this.opMap[this.accs[i].Id][k].phone__c;
                    if(Products.length>0){
                        obj3.Products=Products;
                    }
                    
                    filterOpp.push(obj3);
                  }  
                  } 
                }
                
            }
        Opportunities=filterOpp;
        let obj2 = {};
        obj2.Id=this.conMap[this.accs[i].Id][j].Id;
        obj2.Name = this.conMap[this.accs[i].Id][j].LastName;
        obj2.Phone =this.conMap[this.accs[i].Id][j].Phone;
        if(Opportunities.length>0){
        obj2.Opportunities = Opportunities;
        }
        
        filterCon.push(obj2);  
        }
        
        Contacts=filterCon
        let obj = {};
        obj.Id=this.accs[i].Id;
        obj.Name = this.accs[i].Name;
        obj.Phone = this.accs[i].Phone;
        if(Contacts.length >=2 ){
            obj.Contacts = [Contacts[0],Contacts[1]];  
        }
        else{
        obj.Contacts = [Contacts[0]];
           
        }
        
        filterAcc.push(obj);
        
        
     }
      this.accs=filterAcc.map(a => ({ ...a, IsEditable: false, view : a.Contacts.length >=2 ? true:false ,}));

      this.dummyaccs=this.accs;
      
      this.accs = this.accs.map(acc => ({
                    ...acc,
                    Contacts: acc.Contacts.map(contact => ({
                        ...contact,
                        IsEditable: false,
                        IsEditablePhone:false
                    }))
                }));
                this.accs = this.accs.map(acc => ({
                    ...acc,
                    Contacts: acc.Contacts.map(contact => ({
                        ...contact,
                        Opportunities: contact.Opportunities ? 
                            contact.Opportunities.map(opp => ({ ...opp, IsEditable: false,IsEditablePhone:false })) :
                            undefined
                    }))
                }));
                this.accs = this.accs.map(acc => ({
                    ...acc,
                    Contacts: acc.Contacts.map(contact => ({
                        ...contact,
                        Opportunities: contact.Opportunities ? contact.Opportunities.map(opp => ({
                            ...opp,
                            Products: opp.Products ? opp.Products.map(prod => ({
                                ...prod,
                                IsEditable: false,IsEditablePhone:false
                            })) : undefined
                        })) : undefined
                    }))
                }));
                this.accs = this.accs.map(acc => ({
                    ...acc,
                    Contacts: acc.Contacts.map(contact => ({
                        ...contact,
                        Opportunities: contact.Opportunities ? contact.Opportunities.map(opp => ({
                            ...opp,
                            Products: opp.Products ? opp.Products.map(prod => ({
                                ...prod,
                                PriceBooks: prod.PriceBooks ? prod.PriceBooks.map(priceBook => ({
                                    ...priceBook,
                                        IsEditable: false ,
                                        IsEditablePhone:false
                                    })) : undefined
                                })) : undefined
                            })) : undefined
                        
                    }))
                }));
                
                
    }
    navigateToRecord(event) {
        console.log('Navigating to record...');
        console.log('Event target:', event.target); // Check what event.target references
        const recId = event.target.dataset.id;
        console.log('Record ID:', recId); // Check if recId is correctly retrieved
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recId,
                actionName: 'view'
            }
        });
    }
    handleEditing(event){
        this.acId=event.currentTarget.dataset.id;
        console.log('acId--',this.acId);
        this.displayedaccs = this.displayedaccs.map(a => ({
            ...a,
            IsEditable: a.Id === this.acId ? true : false,
        }));
        this.SaveAll=true;
        this.cancel=true;


    }
    handleFields(event) {
        var field = event.currentTarget.dataset.field;
        var value = event.target.value;
        console.log(' handle field is field--------------', field);
        console.log(' handle field is value--------------', value);
        this.accs = this.accs.map(a => ({
            ...a,
            [field]: a.Id === this.acId ? value : a[field]
        }));
    }
    handleEditing2(event){
        this.conId = event.currentTarget.dataset.id;
        console.log('id-', this.conId);
        this.displayedaccs = this.displayedaccs.map(acc => ({
            ...acc,
            Contacts: acc.Contacts.map(contact => ({
                ...contact,
                IsEditable: contact.Id === this.conId ? true : false,
            }))
        }));
        this.SaveAll=true;
        this.cancel=true;
    }
handleFields2(event){
    var field = event.currentTarget.dataset.field;
    var value = event.target.value;
    console.log('handle field is field--------------', field);
    console.log('handle field is value--------------', value);
    this.accs = this.accs.map(acc => ({
        ...acc,
        Contacts: acc.Contacts.map(contact => ({
            ...contact,
            [field]: contact.Id === this.conId ? value : contact[field]
        }))
    }));

}
handleEditing3(event){
    this.oppId = event.currentTarget.dataset.id;
    console.log('opid--',this.oppId);
    this.displayedaccs = this.displayedaccs.map(acc => ({
        ...acc,
        Contacts: acc.Contacts.map(contact => ({
            ...contact,
            Opportunities: contact.Opportunities ? 
                contact.Opportunities.map(opp => ({ ...opp, IsEditable: opp.Id === this.oppId ? true : false})) :
                undefined
        }))
    }));
    this.SaveAll=true;
    this.cancel=true;

}
handleFields3(event) {
    var field = event.currentTarget.dataset.field;
    var value = event.target.value;
    console.log('handle field is field--------------', field);
    console.log('handle field is value--------------', value);
    this.accs = this.accs.map(acc => ({
        ...acc,
        Contacts: acc.Contacts.map(contact => ({
            ...contact,
            Opportunities: contact.Opportunities ? 
                contact.Opportunities.map(opp => ({ ...opp,
                [field]: opp.Id === this.oppId ? value : opp[field] 
            })) : undefined
        }))
    }));
}
handleEditing4(event){
    this.productId = event.currentTarget.dataset.id;
    console.log('proid---',this.productId);
    this.displayedaccs = this.displayedaccs.map(acc => ({
        ...acc,
        Contacts: acc.Contacts.map(contact => ({
            ...contact,
            Opportunities: contact.Opportunities ? contact.Opportunities.map(opp => ({
                ...opp,
                Products: opp.Products ? opp.Products.map(prod => ({
                    ...prod,
                    IsEditable: prod.Id === this.productId ? true : false,
                })):undefined
            })):undefined
        }))
    }));
    this.SaveAll=true;
    this.cancel=true;

}
handleFields4(event) {
    var field = event.currentTarget.dataset.field;
var value = event.target.value;
console.log('handle field is field--------------', field);
console.log('handle field is value--------------', value);
this.accs = this.accs.map(acc => ({
    ...acc,
    Contacts: acc.Contacts.map(contact => ({
        ...contact,
        Opportunities: contact.Opportunities ? 
            contact.Opportunities.map(opp => ({
                ...opp,
                Products: opp.Products ?
                    opp.Products.map(prod => ({
                        ...prod,
                        [field]: prod.Id === this.productId ? value : prod[field]
                    })) : undefined
            })) : undefined
    }))
}));

}
handleEditing5(event){
    this.priceId = event.currentTarget.dataset.id;
    console.log('proid---', this.priceId);
    this.displayedaccs = this.displayedaccs.map(acc => ({
        ...acc,
        Contacts: acc.Contacts.map(contact => ({
            ...contact,
            Opportunities: contact.Opportunities ? contact.Opportunities.map(opp => ({
                ...opp,
                Products: opp.Products ? opp.Products.map(prod => ({
                    ...prod,
                    PriceBooks: prod.PriceBooks ? prod.PriceBooks.map(priceBook => ({
                        ...priceBook,
                        IsEditable: priceBook.Id === this.priceId ? true : false,
                
                    })) : undefined
                })) : undefined
            })) : undefined
        }))
    }));
    this.SaveAll=true;
    this.cancel=true;

}

handleFields5(event){
    var field = event.currentTarget.dataset.field;
    var value = event.target.value;
    console.log('handle field is field--------------', field);
    console.log('handle field is value--------------', value);
    this.accs = this.accs.map(acc => ({
        ...acc,
        Contacts: acc.Contacts.map(contact => ({
            ...contact,
            Opportunities: contact.Opportunities ? contact.Opportunities.map(opp => ({
                ...opp,
                Products: opp.Products ? opp.Products.map(prod => ({
                    ...prod,
                    PriceBooks: prod.PriceBooks ? prod.PriceBooks.map(priceBook => ({
                        ...priceBook,
                        [field]: priceBook.Id === this.priceId ? value : prod[field]
                    })) : undefined
                })) : undefined
            })) : undefined
        }))
    }));

}


    handleCancel(){
        this.displayedaccs = this.accs.map(acc => ({
            ...acc,
            IsEditable: false,
            IsEditablePhone: false,
            Contacts: acc.Contacts.map(contact => ({
                ...contact,
                IsEditable: false,
                IsEditablePhone: false,
                Opportunities: contact.Opportunities ? contact.Opportunities.map(opp => ({
                    ...opp,
                    IsEditable: false,
                    IsEditablePhone: false,
                    Products: opp.Products ? opp.Products.map(prod => ({
                        ...prod,
                        IsEditable: false,
                        IsEditablePhone: false,
                        PriceBooks: prod.PriceBooks ? prod.PriceBooks.map(pb => ({
                            ...pb,
                            IsEditable: false,
                            IsEditablePhone: false
                        })) : undefined
                    })) : undefined
                })) : undefined
            }))
        }));
        this.cancel=false;
        this.SaveAll=false;

    }
    getData(){
        const startIndex = (this.currentPage - 1) * this.pageSize;
        const endIndex = startIndex + this.pageSize;
        this.displayedaccs = this.accs.slice(startIndex, endIndex);
}
get disablePrevious() {
    return this.currentPage == 1;
}

get disableNext() {
    return !this.accs || this.currentPage == Math.ceil(this.accs.length / this.pageSize);
}

handlePrevious() {
    if (!this.disablePrevious) {
        this.getData();
        this.currentPage--;
        this.getData();
    }
}

handleNext() {
    if (!this.disableNext) {
        this.currentPage++;
        this.getData();
    }
}
handleSaveButtonAll(){
    console.log('insave==');
    this.getData();
    var updatedAccount = this.accs.find(a => a.Id === this.acId);
    var updatedcon;
    var updatedContact;
    this.displayedaccs.forEach(acc => {
         updatedContact = acc.Contacts.find(contact => contact.Id === this.conId);
         if(updatedContact){
            updatedcon=updatedContact;
         }
         
    });
    var updatedOpportunity;
    this.displayedaccs.forEach(acc => {
        acc.Contacts.forEach(contact => {
            if (contact.Opportunities) {
                const updatedOpp = contact.Opportunities.find(opp => opp.Id === this.oppId);
                if (updatedOpp) {
                    updatedOpportunity = updatedOpp;
                }
            }
        });
    });
    var updatedProduct;
console.log('in save---');
this.displayedaccs.forEach(acc => {
    acc.Contacts.forEach(contact => {
        if (contact.Opportunities) {
            contact.Opportunities.forEach(opp => {
                if (opp.Products) {
                    const updatedProd = opp.Products.find(prod => prod.Id === this.productId);
                    if (updatedProd) {
                        updatedProduct = updatedProd;
                    }
                }
            });
        }
    });
});
var updatedPriceBook;
this.displayedaccs.forEach(acc => {
    acc.Contacts.forEach(contact => {
        if (contact.Opportunities) {
            contact.Opportunities.forEach(opp => {
                if (opp.Products) {
                    opp.Products.forEach(prod => {
                        if (prod.PriceBooks) {
                            const updatedPB = prod.PriceBooks.find(pb => pb.Id === this.priceId);
                            if (updatedPB) {
                                updatedPriceBook = updatedPB;
                            }
                        }
                    });
                }
            });
        }
    });
});
    
    
        const promises = [];
    
        if (updatedAccount) {
            const recordInput = {
                Id: this.acId,
                Name: updatedAccount.Name,
                Phone: updatedAccount.Phone,
            };
            promises.push(updateAccounts({ accData: recordInput }));
        }
    
        if (updatedcon) {
            const recordInput = {
                Id: this.conId,
                Name: updatedcon.Name,
                Phone: updatedcon.Phone,
            };
            promises.push(updateContacts({ conData: recordInput }));
        }
    
        if (updatedOpportunity) {
            const recordInput = {
                Id: this.oppId,
                Name: updatedOpportunity.Name,
                Phone: updatedOpportunity.Phone,
            };
            promises.push(updateOpportunities({ oppData: recordInput }));
        }
    
        if (updatedProduct) {
            const recordInput = {
                Id: this.productId,
                Name: updatedProduct.Name,
                Phone: updatedProduct.Phone,
            };
            promises.push(updateProducts({ prodData: recordInput }));
        }
    
        if (updatedPriceBook) {
            const recordInput = {
                Id: this.priceId,
                Name: updatedPriceBook.Name,
                Phone: updatedPriceBook.Phone,
            };
            promises.push(updatePriceBooks({ priceData: recordInput }));
        }
    
        Promise.all(promises)
            .then(results => {
                console.log('results--',results);
                this.displayedaccs = this.accs.map(acc => ({
                    ...acc,
                    IsEditable: false,
                    IsEditablePhone: false,
                    Contacts: acc.Contacts.map(contact => ({
                        ...contact,
                        IsEditable: false,
                        IsEditablePhone: false,
                        Opportunities: contact.Opportunities ? contact.Opportunities.map(opp => ({
                            ...opp,
                            IsEditable: false,
                            IsEditablePhone: false,
                            Products: opp.Products ? opp.Products.map(prod => ({
                                ...prod,
                                IsEditable: false,
                                IsEditablePhone: false,
                                PriceBooks: prod.PriceBooks ? prod.PriceBooks.map(pb => ({
                                    ...pb,
                                    IsEditable: false,
                                    IsEditablePhone: false
                                })) : undefined
                            })) : undefined
                        })) : undefined
                    }))
                }));
            })
            .catch(error => {
                // Handle error
            });
    this.SaveAll=false;
    this.cancel=false;
    this.currentPage=1;
        
    }
     handleSearch(event) {
        const searchTerm = event.target.value.trim().toLowerCase();
        console.log('search value ==', searchTerm);
        if (searchTerm === '') {
            this.accs = this.dummyaccs;
        } 
        else {
            this.accs = this.dummyaccs.filter(account =>
                account.Name.toLowerCase().includes(searchTerm)
            );
        }
        this.currentPage=1;
        this.getData();
            
        
        }
        handleViewAll(event){
            const recordId = event.target.dataset.id;
            this[ NavigationMixin.Navigate ]( {
                type: 'standard__recordRelationshipPage',
                attributes: {
                    recordId: recordId,
                    objectApiName: 'Account',
                    relationshipApiName: 'Contacts',
                    actionName: 'view'
                }
            } );
        }
    handleRowSelect(event){
        console.log('inrowwww');
        const selId=event.target.dataset.id;
        const ischecked=event.target.checked;
        if (ischecked) {
            this.selectedRows = [...this.selectedRows, selId];
            console.log('selrow--',JSON.stringify(this.selectedRows));
            this.selectedAccountDetails = this.accs.filter(account => this.selectedRows.includes(account.Id));
            console.log('accdeatils---',JSON.stringify(this.selectedAccountDetails));
            this.expor=true;
        } 
        else{
            this.expor=false;
        }
        
    }
    handleSelectAll(event){
        const isChecked = event.target.checked;
        if (isChecked) {
            const boxes = this.template.querySelectorAll('lightning-input');
            boxes.forEach(box =>
            box.checked = true
        );
            this.selectedRows = this.displayedaccs.map(a => a.Id);
            this.selectedAccountDetails = this.accs.filter(account => this.selectedRows.includes(account.Id));
        } else {
            const boxes = this.template.querySelectorAll('lightning-input');
            boxes.forEach(box =>
            box.checked = false
        );
         this.expor=false;
            this.selectedRows = [];
        }
        this.expor=true;
    }
    handleExport(){
        console.log('inexpo---');
        this.comp2=true;
        const boxes = this.template.querySelectorAll('lightning-input');
            boxes.forEach(box =>
            box.checked = false
        );
    }

    }