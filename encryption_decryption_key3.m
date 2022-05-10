
%% Declare
M = 0;
GDC = 0;
det_k = 0;
En_msg = '';
New_De_msg = '';
f = 0;
b = 0;
c = 0;
d = 0;
e = 0;
K11 = input('Enter matrix k \n Enter a value for K11: '); %3
K12 = input('\n Enter a value for K12: '); %10
K13 = input('\n Enter a value for K13: '); %20
K21 = input('\n Enter a value for K21: '); %20
K22 = input('\n Enter a value for K22: '); %9
K23 = input('\n Enter a value for K23: '); %17
K31 = input('\n Enter a value for K31: '); %9
K32 = input('\n Enter a value for K32: '); %4
K33 = input('\n Enter a value for K33: '); %17
k = [K11 K12 K13; K21 K22 K23; K31 K32 K33]

%% consider the condition for the existence of an inverse matrix
det_k = det(k);
det_k = mod(det_k, 26);
det_k = int8(det_k);
% find greatest common divisor
M = 26;
while det_k ~= 0 && M ~= 0
    if det_k > M
        det_k = det_k - M;
    else
        M = M - det_k;
    end
end
GDC = det_k + M;
    
    %% enter string to be encrypted
    if GDC == 1
        a = input('Please enter the string to be encrypted \n','s');
        while mod(length(a),3)~= 0
            disp ('!!! please enter a string with total characters divisible 3');
            a = input('Please enter the string to be encrypted \n','s');
        end
        %Transfer message from matlab code to mod 26
        msg = double(a);
        msg = msg - 65;

       %% Encryption 
        msg = reshape(msg,3,length(a)/3);
        new_msg = k*msg;
        new_msg = mod( new_msg, 26);
        new_msg = reshape( new_msg,1,length(a));
        new_msg = new_msg +65;
        En_msg = char(new_msg);
        fprintf ('encryption msg: %s \n',En_msg);

  
        %% find (det_k)^-1
        det_k = det(k);
        det_k = mod(det_k,26);
        det_k = int8(det_k);
        for count = 1:25                 
            d = det_k*count;
            e = mod( d, 26);
            if(e == 1)
                f = d/det_k;
                break
            end
        end
       %% trans key
       K = [K11 K21 K31; 
            K12 K22 K32; 
            K13 K23 K33];
           
       %% find adj(k)
        a_K11 = K22*K33 - K32*K23;
        a_K12 = (K12*K33 - K13*K32)*-1;
        a_K13 = (K12*K23 - K13*K22);
        a_K21 = (K21*K33 - K23*K31)*-1;
        a_K22 = K11*K33 - K13*K31;
        a_K23 = (K11*K23 - K13*K21)*-1;
        a_K31 = (K21*K32 - K22*K31);
        a_K32 = (K11*K32 - K12*K31)*-1;
        a_K33 = K11*K22 - K21*K12;
        a_k = [a_K11 a_K12 a_K13; a_K21 a_K22 a_K23; a_K31 a_K32 a_K33];

       %% find k^-1
        f = double(f);
        invert_k = f*a_k;
        invert_k = mod( invert_k, 26);

       %% Decryption 
        Temp_De_msg = new_msg;
        De_msg = double(Temp_De_msg);
        De_msg = De_msg - 65;
        De_msg = reshape(De_msg,3,length(a)/3);
        New_De_msg = invert_k*De_msg;
        New_De_msg = mod (New_De_msg,26);
        New_De_msg = reshape(New_De_msg,1,length(a));
        New_De_msg = New_De_msg + 65;
        New_De_msg = char (New_De_msg);
        fprintf ('Decryption msg: %s \n',New_De_msg);
    else 
        disp ('there is no encryption matrix')
        En_msg = '';
        New_De_msg = '';
    end

    








