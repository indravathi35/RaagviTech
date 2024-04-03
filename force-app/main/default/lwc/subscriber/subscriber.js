import { LightningElement,wire } from 'lwc';
import pubSub from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
export default class Subscriber extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    message = '';

    connectedCallback() {
        // subscribe to sendmessage event
        pubSub.registerListener("sendmessage", this.handleIncomingMessage, this);
    }

    disconnectedCallback() {
        
        unregisterAllListeners(this);
    }

    handleIncomingMessage(message){
        this.message = message;
    }

}