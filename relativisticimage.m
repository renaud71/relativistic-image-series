%% script: Renaud Toussaint, CNRS, Juillet 2018. renaud.toussaint@unistra.fr
beta=0.9;  
%%% rapport vitesse de l objet sur vitesse de la lumiere, 300000 km par s
gamma=1/sqrt(1-beta*beta);
d=20; % distance du plan ou passe l objet en m
dp=d;   % par defaut, =d, on change si on veut un appareil photo a une distance differente de l objet
A=imread('ours-sur-un-velo.png');  % nom de l'image qui va passer de haut en bas. Changer pour une autre image.
sizex=size(A,1);
sizey=size(A,2);
sizenewimx=470;
sizenewimy=470;
step=10;  %pas en temps entre deux images. unite du pas de temps: 1 m sur c  = 1 m sur 300 000 000 m par s = 3 ns - avec step=10, une im tous les 33 ns, joué à 30 impar s: ralenti 30 par 33.10^-9 = 1 milliards de fois
imshow(A);
%figure;
ic=floor(sizex/2);
jc=floor(sizey/2);
icnew=floor(sizenewimx/2);
jcnew=floor(sizenewimy/2);
for tcount=0:3*sizenewimx/step;
    t=tcount*step-2*sizenewimx/3;
    B=uint8(122.*ones(sizenewimx,sizenewimy,3));
    for i=1:sizenewimx;
        for j=1:sizenewimy;
            inewpp=ic+d/dp*(i-icnew);
            jnewpp=jc+d/dp*(j-jcnew);
            inew=floor(gamma*((inewpp-ic)-beta*(t-sqrt((inewpp-ic)*(inewpp-ic)+(jnewpp-jc)*(jnewpp-jc)+d*d)))+ic);
            jnew=floor(jnewpp-jc)+jc;
            if(inew>1&jnew>1&inew<sizex&jnew<sizey)
                B(i,j,:)=A(inew,jnew,:);
                A(inew,jnew,:);
            end
        end
    end
%C=B;imshow(C);
    stringname=sprintf('%04d',tcount);
    filename1=strcat('relim',stringname);
    filename=strcat(filename1,'.bmp');
    imwrite(B,filename,'BMP');
end;
