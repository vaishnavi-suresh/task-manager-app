

export function checkPromise(promise, res){
    promise.then(
        result=>{
            if(result){
                console.log('hello');
                return res.send(result);
            } else{
                return res.status(404).send();
                
            }
        }
    ).catch(e=>{return res.status(500).send({error:e.message})});

};
