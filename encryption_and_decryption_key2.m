
%% Declare
M = 0;
GDC = 0;
temp_det_k = 0;
det_k = 0;
En_msg = '';
New_De_msg = '';
a = '';
K11 = input('Enter matrix k \n Enter a value for K11: '); %5
K12 = input('\n Enter a value for K12: '); %5
K21 = input('\n Enter a value for K21: '); %8
K22 = input('\n Enter a value for K22: '); %9
k = [K11 K12; K21 K22]

%% consider the condition for the existence of an inverse matrix
det_k = K11*K22 - K21*K12;
det_k = mod(det_k,26);

    %% find greatest common divisor
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
        GDC =0;
        a = input('Please enter the string to be encrypted \n','s');
        while mod(length(a),2)~= 0
            disp ('!!! please enter a string with even total characters');
            a = input('Please enter the string to be encrypted \n','s');
        end
        %Transfer message from matlab code to mod 26
        msg = double(a);
        msg = msg - 65;

       %% Encryption 
        msg = reshape(msg,2,length(a)/2);
        new_msg = k*msg;
        new_msg = mod( new_msg, 26);
        new_msg = reshape( new_msg,1,length(a));
        new_msg = new_msg +65;
        En_msg = char(new_msg);
        fprintf ('encryption msg: %s \n',En_msg);

  
        %% find (det_k)^-1
        det_k = K11*K22 - K21*K12;
        det_k = mod(det_k,26);
        for count = 1:25                 
            d = det_k*count;
            e = mod( d, 26);
            if(e == 1)
                f = d/det_k;
                break
            end
        end

       %% find adj(k)
        b = mod (-K12,26);
        c = mod (-K21,26);
        temp_k = [K22 b;c K11];

       %% find k^-1
        invert_k = f*temp_k;
        invert_k = mod( invert_k, 26);

       %% Decryption 
        Temp_De_msg = new_msg;
        De_msg = double(Temp_De_msg);
        De_msg = De_msg - 65;
        De_msg = reshape(De_msg,2,length(a)/2);
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

    








