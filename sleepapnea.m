% Load the first audio signal (replace with your first input signal)
[input_signal1, fs1] = audioread('inputsignal_test1.wav');

% Load the second audio signal (replace with your second input signal)
[input_signal2, fs2] = audioread('inputsignal_test2.wav');

% Preprocessing
% Apply a Hamming window to each signal
window = hamming(512); % Define a window of length 512 samples
input_signal1 = input_signal1 .* window;
input_signal2 = input_signal2 .* window;

% Compute the Short-Time Fourier Transform (STFT) for both signals
nfft = 512; % Set the FFT length
hop_size = 256; % Set the hop size
stft1 = spectrogram(input_signal1, window, hop_size, nfft);
stft2 = spectrogram(input_signal2, window, hop_size, nfft);

% Extract Mel-Frequency Cepstral Coefficients (MFCCs) as spectral features
num_mfccs = 13; % Number of MFCC coefficients to extract
mfcc1 = mfcc(input_signal1, fs1, 'NumCoeffs', num_mfccs);
mfcc2 = mfcc(input_signal2, fs2, 'NumCoeffs', num_mfccs);

% Normalize the MFCC features
mfcc1 = zscore(mfcc1);
mfcc2 = zscore(mfcc2);

% Calculate the cosine similarity between the feature vectors
cosine_similarity = dot(mfcc1(:), mfcc2(:)) / (norm(mfcc1(:)) * norm(mfcc2(:)));

% Define a similarity threshold (you may need to determine this experimentally)
similarity_threshold = 0.8;

% Check if cosine similarity exceeds the threshold
if cosine_similarity > similarity_threshold
    disp('The person may have sleep apnea.');
else
    disp('The person may not have sleep apnea.');
end

% Visualization
% Plot the first input signal
subplot(3, 2, [1, 2]);
plot(input_signal1);
title('Input Signal 1');
xlabel('Sample');
ylabel('Amplitude');

% Plot the second input signal
subplot(3, 2, [3, 4]);
plot(input_signal2);
title('Input Signal 2');
xlabel('Sample');
ylabel('Amplitude');

% Visualize MFCC features for the first signal
subplot(3, 2, 5);
imagesc(mfcc1);
colormap('jet');
title('MFCC Features (Signal 1)');
xlabel('Frame');
ylabel('MFCC Coefficient');

% Visualize MFCC features for the second signal
subplot(3, 2, 6);
imagesc(mfcc2);
colormap('jet');
title('MFCC Features (Signal 2)');
xlabel('Frame');
ylabel('MFCC Coefficient');