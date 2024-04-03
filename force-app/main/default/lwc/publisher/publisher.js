import { LightningElement,wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import pubSub from 'c/pubsub'
export default class Publisher extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    message = '';

    handleMessageChange(event){
        this.message = event.target.value;
    }

    handlePublish(){
        
        pubSub.fireEvent(this.pageRef, 'sendmessage', this.message);
        this.message = '';
    }
}