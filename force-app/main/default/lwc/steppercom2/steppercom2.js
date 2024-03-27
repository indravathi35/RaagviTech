import { LightningElement ,api,wire,track} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import methodName from '@salesforce/apex/GetAddress.methodName';
export default class Steppercom2 extends NavigationMixin(LightningElement) {
  @api recId;
  @track accs;
  @track address;
  @wire(methodName,{recId: "$recId"})
wiredContacts({ error, data }) {

    if (data) {
   
        this.accs = data;
        this.address=this.accs[0].BillingCity;
    } else if (error) {

        this.error = error;

    }
  }
  
steppercom3(){
  console.log('data---',this.accs[0].BillingCity);
  console.log('In steppercom3');
  console.log('id',this.recId);
  let componentDef = {
    componentDef: "c:steppercom3",
    attributes: {
        label: 'Navigated From Another LWC Without Using Aura',
        reccaseId:this.recId,
        ad:this.address
    }
};

let encodedComponentDef = btoa(JSON.stringify(componentDef));
this[NavigationMixin.Navigate]({
    type: 'standard__webPage',
    attributes: {
        
        url: '/one/one.app#' + encodedComponentDef,
        
        
    },

});

}
}