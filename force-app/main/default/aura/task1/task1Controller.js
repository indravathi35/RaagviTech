// YourAuraComponentController.js
({
    doInit: function(component, event, helper) {
        
                var path = $A.get("$Resource.taskaura");
                console.log('path',path);
                var req = new XMLHttpRequest();
                console.log('req',req);
                req.open("GET", path);
                req.addEventListener("load", $A.getCallback(function() {
                var jsonResponse = JSON.parse(req.response);
                //console.log(JSON.stringify(jsonResponse));
                var stringArray=[];
                var concauth=jsonResponse.ConcessionAuthority.authority;
                console.log('concauth---------------'+jsonResponse.ConcessionAuthority.authority);
                var cardtype=jsonResponse.cardType.CentreLink;
                console.log('cardtype1---------------'+jsonResponse.cardType.CentreLink);
                var cardtype2=jsonResponse.cardType.Department_of_Veteran_Affairs;
                console.log('cardtype2---------------'+jsonResponse.cardType.Department_of_Veteran_Affairs);


                for(let i=0;i<jsonResponse.fields.length;i++){
                    console.log('fields---------------'+jsonResponse.fields[i].Name);
                    stringArray.push(jsonResponse.fields[i].Name);
                }
                /*
                for(let i=0;i<jsonResponse.ConcessionAuthority.authority.length;i++)
                {
                    concauth.push(jsonResponse.ConcessionAuthority.authority[i].label);
                    console.log('concauth---------------'+jsonResponse.ConcessionAuthority.authority[i].label);

                }
                for(let i=0;i<jsonResponse.cardType.CentreLink.length;i++)
                {
                    cardtype.push(jsonResponse.cardType.CentreLink[i].label);
                    console.log('cardtype---------------'+jsonResponse.cardType.CentreLink[i].label);


                }
                 for(let i=0;i<jsonResponse.cardType.Department_of_Veteran_Affairs.length;i++)
                 {
                    cardtype2.push(jsonResponse.cardType.Department_of_Veteran_Affairs[i].label);
                    console.log('cardtype2-----'+jsonResponse.cardType.Department_of_Veteran_Affairs[i].label);

                }*/
                

                //console.log(JSON.stringify(jsonResponse.fields[0].Name))
                //console.log(component.set("v.firstfield",JSON.stringify(jsonResponse.fields[0].Name)));
                component.set('v.options',stringArray);
                component.set('v.concauth',concauth);
                component.set('v.cardtype',cardtype);
                component.set('v.cardtype2',cardtype2);
                
                }));
                req.send(null);
            
        
    }
})