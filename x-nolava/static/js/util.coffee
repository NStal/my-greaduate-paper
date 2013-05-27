Static.InterpolationStep = (object,target,attributes,limit,useNorm = false,destination={})->
    diffArray = []
    for item in attributes
        console.assert typeof target[item] is "number"
        console.assert typeof object[item] is "number"
        diffArray.push(target[item]-object[item])
    if useNorm
        total = 0
        for item in diffArray
            total += item*item
        norm = Math.sqrt(total)
        if norm is 0
            norm = 0.00001
        for item,index in diffArray 
            diffArray[index] = item/norm*limit
    else
        for item,index in diffArray
            if Math.abs(item)>limit
                diffArray[index] = Math.abs(item)/item*limit
    for attr,index in attributes
        destination[attr] = diffArray[index]
    return destination
    
Static.Interpolation = (object,target,attributes,limit,useNorm = false,destination={})->
    
    destination = Static.InterpolationStep(object,target,attributes,limit,useNorm,destination)
    for item,index in attributes
        destination[item] += object[item];
        if (destination[item] - target[item])*(object[item]-target[item]) < 0
            #exceed
            destination[item] = target[item]
    return destination