import { LightningElement,api,wire } from 'lwc';
import fetchOppData from '@salesforce/apex/OppWrapperController.fetchOppData';
export default class AccOppRecords extends LightningElement {
    value;
    title;
    checklabel='getOpportunities';
    displayedaccs = [];
    displayedopps=[];
    currentPage = 1;
    pageSize = 10;
    accounts=[];
    opportunities=[];
    @api resultData;
    handleChange(event){
        this.value=event.target.checked;
        console.log('val----',this.value);
        if(this.value==false){
           this.checklabel='getOpportunities';
        }
        else{
            this.checklabel='getAccounts';
        }
       
    }
     connectedCallback() {
        
        fetchOppData()
        .then(result => {
        if(result){
        this.resultData= result;
        console.log('data--',JSON.stringify(this.resultData));
        this.accounts = this.resultData.accList;
        console.log('acc---',this.accounts);
        this.opportunities=this.resultData.oppList;
        console.log('opp--',this.opportunities);
        
    }
    this.getData();
})
.catch(error => {
    this.error = error;
});
        
    }
getData(){
        const startIndex = (this.currentPage - 1) * this.pageSize;
        const endIndex = startIndex + this.pageSize;
        this.displayedaccs = this.accounts.slice(startIndex, endIndex);
        this.displayedopps= this.opportunities.slice(startIndex, endIndex);
        console.log('index',startIndex,endIndex,this.displayedaccs);
}
  
get disablePrevious1() {
    return this.currentPage == 1;
}

get disableNext1() {
    return this.currentPage == Math.ceil(this.accounts.length / this.pageSize);
}

handlePrevious1() {
    if (!this.disablePrevious1) {
        this.currentPage--;
        this.getData();
    }
}

handleNext1() {
    if (!this.disableNext1) {
        this.currentPage++;
        this.getData();
    }
}
get disablePrevious2() {
    return this.currentPage == 1;
}

get disableNext2() {
    return this.currentPage == Math.ceil(this.opportunities.length / this.pageSize);
}

handlePrevious2() {
    if (!this.disablePrevious2) {
        this.currentPage--;
        this.getData();
    }
}

handleNext2() {
    if (!this.disableNext2) {
        this.currentPage++;
        this.getData();
    }
}

}