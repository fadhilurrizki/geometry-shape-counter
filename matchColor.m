function [hasil1,hasil2] = matchColor(ciri1)

load red.mat
mred = cm;
load green.mat
mgreen = cm;
load blue.mat
mblue = cm;
load yellow.mat
myellow = cm;

warna_model = struct('nama',{});
warna_model(1).nama = 'merah';
warna_model(2).nama = 'hijau';
warna_model(3).nama = 'biru';
warna_model(4).nama = 'kuning';
warna_model(5).nama = 'unknown';

d1=0;
for i=1:3
    d1=d1+(i*abs(ciri1((3*(i-1))+1)-mred((3*(i-1))+1))) + (2*i*abs(ciri1((3*(i-1))+2)-mred((3*(i-1))+2))) + (3*i*abs(ciri1((3*(i)))-mred((3*(i)))));
end
d2=0;
for i=1:3
    d2=d2+(i*abs(ciri1((3*(i-1))+1)-mgreen((3*(i-1))+1))) + (2*i*abs(ciri1((3*(i-1))+2)-mgreen((3*(i-1))+2))) + (3*i*abs(ciri1((3*(i)))-mgreen((3*(i)))));
end
d3=0;
for i=1:3
    d3=d3+(i*abs(ciri1((3*(i-1))+1)-mblue((3*(i-1))+1))) + (2*i*abs(ciri1((3*(i-1))+2)-mblue((3*(i-1))+2))) + (3*i*abs(ciri1((3*(i)))-mblue((3*(i)))));
end
d4=0;
for i=1:3
    d4=d4+(i*abs(ciri1((3*(i-1))+1)-myellow((3*(i-1))+1))) + (2*i*abs(ciri1((3*(i-1))+2)-myellow((3*(i-1))+2))) + (3*i*abs(ciri1((3*(i)))-myellow((3*(i)))));
end

d = [d1,d2,d3,d4];
[id,d] = sort(d);

hasil1 = d(1);
if(hasil1==1)
    if((id(1)>3500))
      hasil1=5;
    end
  end
  if(hasil1==2)
    if((id(1)>3000))
      hasil1=5;
    end
  end
  if(hasil1==4)
    if((id(1)>2500))
      hasil1=5;
    end
  end
  
  if(hasil1==3)
    if((id(1)>1000))
            hasil1=5;
    end
  end
hasil2 = warna_model(hasil1).nama;
end