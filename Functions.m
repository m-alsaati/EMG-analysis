function [mrs, vrs, dyn, avg, root] = Functions(signal, windowsize)

% Zero-padding 
for k = length(signal) : length(signal) + windowsize 
    signal(k) = 0;
end

for i=1:length(signal)-windowsize 
    mrs(i) = mean(abs(signal(i:i+windowsize-1)));
    vrs(i) = var(signal(i:i+windowsize-1)); 
    dyn(i) = max(signal(i:i+windowsize-1))-min(signal(i:i+windowsize-1));
    avg(i) = mean((signal(i:i+windowsize-1)).^2);
    root(i) = rms(signal(i:i+windowsize-1)); 
end 

end