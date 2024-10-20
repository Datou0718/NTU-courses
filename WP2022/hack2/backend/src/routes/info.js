// * ////////////////////////////////////////////////////////////////////////
// *
// * FileName     [ info.js ]
// * PackageName  [ server ]
// * Synopsis     [ Get restaurant info from database ]
// * Author       [ Chin-Yi Cheng ]
// * Copyright    [ 2022 11 ]
// *
// * ////////////////////////////////////////////////////////////////////////

import Info from '../models/info'

exports.GetSearch = async (req, res) => {
    /*******    NOTE: DO NOT MODIFY   *******/
    const priceFilter = req.query.priceFilter
    const mealFilter  = req.query.mealFilter
    const typeFilter  = req.query.typeFilter
    const sortBy      = req.query.sortBy
    /****************************************/

    console.log(priceFilter)
    // NOTE Hint: 
    // use `db.collection.find({condition}).exec(err, data) {...}`
    // When success, 
    //   do `res.status(200).send({ message: 'success', contents: ... })`
    // When fail,
    //   do `res.status(403).send({ message: 'error', contents: ... })`
    
    // TODO Part I-3-a: find the information to all restaurants
    if(sortBy === 'price'){
        Info.find().sort({price: 1}).exec((err, data) => {
            if(err){
                res.status(403).send({message: 'error', contents: 'no restaurant found.'})
            }
            else{
                if(priceFilter){
                    var ret = data.filter((j) => {
                        for(let i = 0; i < priceFilter.length; i++){
                            if(j.price == priceFilter[i])
                                return true;
                        }
                        return false;
                    })
                    data = ret
                }
                if(mealFilter){
                    var ret = data.filter((i) => 
                    ((mealFilter.includes('Breakfast')&&i.tag.includes('Breakfast')) ||
                    (mealFilter.includes('Lunch')&&i.tag.includes('Lunch')) ||
                    (mealFilter.includes('Dinner')&&i.tag.includes('Dinner'))))
                    data = ret       
                }
                if(typeFilter){
                    var ret = data.filter((i) => 
                    ((typeFilter.includes('Chinese')&&i.tag.includes('Chinese')) ||
                    (typeFilter.includes('American')&&i.tag.includes('American')) ||
                    (typeFilter.includes('Italian')&&i.tag.includes('Italian')) ||
                    (typeFilter.includes('Japanese')&&i.tag.includes('Japanese')) ||
                    (typeFilter.includes('Korean')&&i.tag.includes('Korean')) ||
                    (typeFilter.includes('Thai')&&i.tag.includes('Thai'))))
                    data = ret
                }
                res.status(200).send({message: 'success', contents: data})
            }
        })
    }
    else{
        Info.find().sort({distance: 1}).exec((err, data) => {
            if(err){
                res.status(403).send({message: 'error', contents: 'no restaurant found.'})
            }
            else{
                if(priceFilter){
                    var ret = data.filter((j) => {
                        for(let i = 0; i < priceFilter.length; i++){
                            if(j.price == priceFilter[i])
                                return true;
                        }
                        return false;
                    })
                    data = ret
                }
                if(mealFilter){
                    var ret = data.filter((i) => 
                    ((mealFilter.includes('Breakfast')&&i.tag.includes('Breakfast')) ||
                    (mealFilter.includes('Lunch')&&i.tag.includes('Lunch')) ||
                    (mealFilter.includes('Dinner')&&i.tag.includes('Dinner'))))
                    data = ret       
                }
                if(typeFilter){
                    var ret = data.filter((i) => 
                    ((typeFilter.includes('Chinese')&&i.tag.includes('Chinese')) ||
                    (typeFilter.includes('American')&&i.tag.includes('American')) ||
                    (typeFilter.includes('Italian')&&i.tag.includes('Italian')) ||
                    (typeFilter.includes('Japanese')&&i.tag.includes('Japanese')) ||
                    (typeFilter.includes('Korean')&&i.tag.includes('Korean')) ||
                    (typeFilter.includes('Thai')&&i.tag.includes('Thai'))))
                    data = ret
                }
                res.status(200).send({message: 'success', contents: data})
            }
        })
    }
    // TODO Part II-2-a: revise the route so that the result is filtered with priceFilter, mealFilter and typeFilter
    // TODO Part II-2-b: revise the route so that the result is sorted by sortBy
}

exports.GetInfo = async (req, res) => {
    /*******    NOTE: DO NOT MODIFY   *******/
    const id = req.query.id
    /****************************************/
    Info.find({id: id}).exec((err, data) => {
        if(err){
            res.status(403).send({message: 'error', contents: 'no restaurant found.'})
        }
        else{
            res.status(200).send({message: 'success', contents: data})
        }
    })

    // NOTE USE THE FOLLOWING FORMAT. Send type should be 
    // if success:
    // {
    //    message: 'success'
    //    contents: the data to be sent. Hint: A dictionary of the restaruant's information.
    // }
    // else:
    // {
    //    message: 'error'
    //    contents: []
    // }

    // TODO Part III-2: find the information to the restaurant with the id that the user requests
}