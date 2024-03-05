# allergy
An allergy symptoms tracker service in elixir with phoenix framework  

```mermaid
---
title: db Schema
---
erDiagram
  
    Datapoint {
        bool medicine
        string medicinetype
        has_one user
        string symptom
        string region
        int intensity
    }

    User {
        string nickname
    }
    
    Symptom {
        int intensity
        string region
    }

    Region {
        string name
    }
    
    MedicineType {
        string name
    }
```

mix phx.gen.live Accounts User users name:string

mix phx.gen.live Allergy Datapoint datapoints user_id:references:users medicine:boolean medicinetype:string region:string symptom:string intensity:int 
    

