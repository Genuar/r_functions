dist.3d<-function(x,y,z){
  if(length(x)==length(y) && length(x)==length(z))
  {sqrt(sum((diff(x)^2)+(diff(y)^2)+(diff(z)^2)))
  }else{
    print("La longitud de los vectores no es igual")
  }
}
