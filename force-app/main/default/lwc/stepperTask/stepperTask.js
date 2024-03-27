import { LightningElement,api,wire,track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class StepperTask extends  NavigationMixin(LightningElement) {
    @api recordId;
    handleSuccess() {
        let componentDef = {
            componentDef: "c:steppercom2",
            attributes: {
                label: 'Navigated From Another LWC Without Using Aura',
                recId:this.recordId
            }
        };
        
        let encodedComponentDef = btoa(JSON.stringify(componentDef));
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                 
                url: '/one/one.app#' + encodedComponentDef
                
                
            },
    
        });
    }  
}