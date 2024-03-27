import { LightningElement ,track,wire} from 'lwc';
//import jsonfile from '@salesforce/resourceUrl/taskaura';
import resourceMethod from '@salesforce/apex/StaticDataController.resourceMethod';

export default class PicklistTask extends LightningElement {

    @track TypeOptions=[];
    @track pickListValues={};
    @track textFields=[];
    @track pickArray=[];
    @track js;
    @track jsondata='';
    
    /*@wire(resourceMethod)
    wireData({ error, data }) {
        if (data) {
            this.jsondata =JSON.parse(data);
        } else if (error) {
            console.error('Error fetching  data: ', error);
        }

       console.log('jscode----',JSON.stringify(this.jsondata));
    }*/
    connectedCallback() {
        console.log('in concted');
        this.apexclassData();
                //console.log('val---'+this.value);
      }
      apexclassData(){
        resourceMethod()
        .then((result) => {
            console.log('res---'+result);

            this.jsondata=result;   
            console.log('jscode---'+this.jsondata);  
       
        console.log('jscode--11111111111111111-'+this.jsondata); 
        this.js=JSON.parse(this.jsondata);
        console.log('js----'+this.js);
            this.js.fields.forEach(field=>{
                if(field.FieldType==='text'){
                    console.log('text if');
                    this.textFields.push(field);
                }
                else if(field.FieldType ==='combobox'){
                    if(field.Name==='Concession Authority'){
                        
                        this.pickListValues[field.Name]={
                            ...field,
                            options : this.js.ConcessionAuthority.authority
                        };
                    
                    }
                    else if(field.Name==='Card Type'){
                        console.log('i am in inside elese if----');
                        this.pickListValues[field.Name]={
                            ...field,
                            options : this.TypeOptions
                        };
                    }
                  }
                    
                });
      this.pickArray=Object.values(this.pickListValues)
            console.log('pickvalues---'+JSON.stringify(this.pickListValues));
          //this.concauth=this.jsondata.ConcessionAuthority.authority;
          //console.log('concauth'+JSON.stringify(this.concauth));
          //this.cardtype=this.jsondata.cardType.CentreLink;
          //console.log('cardtype---'+JSON.stringify(this.cardtype));
          //this.cardtype2=this.jsondata.cardType.Department_of_Veteran_Affairs;
          //console.log('cardtype2--'+JSON.stringify(this.cardtype2));
          //console.log('op1--------'+this.concauth[0].label);
        });

      }
      handleChange(event)
      {
        const fieldName = event.target.dataset.fieldname;

        const value = event.detail.value;
        console.log('fieldName-------------'+JSON.stringify(fieldName));
        console.log('val---'+value);
        if(fieldName ==='Concession Authority'){
            console.log('i am in inside if');
           this.TypeOptions= this.getOptionsByAuthority(value);
           this.pickListValues['Card Type'].options=this.TypeOptions;

        }
        console.log('tyoe of optikienf---'+JSON.stringify(this.TypeOptions));
        
    }
    getOptionsByAuthority(authorityLabel) {
        console.log('authorityLabel--------------'+JSON.stringify(authorityLabel));
        if (authorityLabel&&this.js.cardType[authorityLabel]) {
            console.log('getOptionsByAuthority');

            return this.js.cardType[authorityLabel].map(option => ({
                
                    label: option.label,
                    value: option.value
                
            }));
        }
        return [];
    }

    
}