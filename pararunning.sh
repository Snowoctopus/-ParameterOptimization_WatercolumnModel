#run the model with parallel computation
doit(){
i=$1
cd  /home/ncg/MogeDu/GLUE/test1/$i
    echo $PWD
    chmod 777 -R MGbase.f90
      ifort MGbase.f90 -o MGbase
       chmod 777 -R /home/ncg/MogeDu/GLUE/test1/.
	  ./MGbase
	  chmod 777 -R /home/ncg/MogeDu/GLUE/test1/.
	  }
	  export -f doit
	  #list the case number in list.txt
	  cat list.txt | parallel doit
