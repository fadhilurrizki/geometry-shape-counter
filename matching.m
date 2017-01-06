function [hasil1,hasil2] = matching(ciri1)

load segiempat.mat
model1 = M;
load lingkaran.mat
model2 = M;
load segitiga.mat
model3 = M;
load segilima.mat
model4 = M;
load bintang.mat
model5 = M;
load red.mat

nama_model = struct('nama',{});
nama_model(1).nama = 'segiempat';
nama_model(2).nama = 'lingkaran';
nama_model(3).nama = 'segitiga';
nama_model(4).nama = 'segilima';
nama_model(5).nama = 'bintang';
nama_model(6).nama = 'unknown';

d1 = 0;
d2=0;
d3=0;
d4=0;
d5=0;
a = 0;
for i=1:7
    d1 = d1+abs(ciri1(i)-model1(i));
    d2 = d2+abs(ciri1(i)-model2(i));
    d3 = d3+abs(ciri1(i)-model3(i));
    d4 = d4+abs(ciri1(i)-model4(i));
    d5 = d5+abs(ciri1(i)-model5(i));
    a=a+ciri1(i);
end
d1=d1/a;
d2=d2/a;
d3=d3/a;
d4=d4/a;
d5=d5/a;

d = [d1,d2,d3,d4,d5];

[id,d] = sort(d);

hasil1 = d(1);
    
  if(hasil1==1)
    if((id(1)>0.004))
      hasil1=6;
    end
  end
  if(hasil1==2)
    if((id(1)>0.02))
      hasil1=6;
    end
  end
  if(hasil1==4)
    if((id(1)>0.01))
      hasil1=6;
    end
  end
  
  if(hasil1==3)
    if((id(1)>0.08))
        if(id(2)<0.14)
            hasil1=d(2);
        else
            hasil1=6;
        end
    end
  end
  if(hasil1==5)
    if((id(1)>0.2))
      hasil1=6;
    end
  end
hasil2 = nama_model(hasil1).nama;