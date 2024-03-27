import { LightningElement } from 'lwc';

export default class TaskTwo extends LightningElement {
        location="Bengaluru";
        temperature=0;
        condition='';
    constructor(){
        super();
        this.fetchData();
    }
    connectedCallback(){
        this.timer=setInterval(this.fetchData(),6000);
    }
    renderedCallback(){
        this.background();
    }
    disconnectedCallback() {
        clearInterval(this.timer);
    }
    fetchData(){
        Location='Benagaluru';
        this.temperature=Math.floor(Math.random(30,45));
        this.condition='Sunny';
    }
    background(){
        if (this.temperature <= 20) {
            this.backgroundColor = 'cold-bg';
        } else if (this.temperature > 20 && this.temperature <= 30) {
            this.backgroundColor = 'moderate-bg';
        } else {
            this.backgroundColor = 'hot-bg';
        }
    }
}