# EMG Analysis
The analysis of Electromyogram (EMG) signals to correlate exertion of force to electrical activity picked up from the muscles.

An EMG signal is a representation of the electrical activity of the nerves which synapses with the muscles of the body. Spatial recruitment is when the body activates multiple muscle fibers in parallel to increase contractile force. Temporal recruitment is when the body increases the frequency of nerve impulses to the muscle fibers to increase contractile force.

<img src="https://github.com/user-attachments/assets/b8f872f2-cb7f-45d2-be12-10d17a327d4f" width="400" height="300">
<img src="https://github.com/user-attachments/assets/040f84f4-eef1-4efb-905e-b3f2350b6f11" width="400" height="300">
<img src="https://github.com/user-attachments/assets/b9d915c5-382d-4694-9027-7c0ee37d5e27" width="400" height="300">

These are the metrics calculated for the analysis:

* Mean Rectified Signal: This metric measures the average of the magnitude of measured electrical activity, meaning it quantifies the amount of muscle contraction.
* Variance of Rectified Signal: The variance shows how far from the mean values of the EMG signal are. This in turn quantifies areas where the signal is around average values but also areas where the signal is much greater than the mean which tells us much more muscle contraction is occurring at that specific moment.
* Dynamic Range: A larger peak-to-peak swing would indicate a larger amplitude. In turn, a larger amplitude quantifies areas of greater muscle contraction.
* Average Power (Mean-Square): The mean-square provides an estimate of the variance in the data. This could quantify for us whether or not there are many spikes in the segment that indicate sudden, large muscle contractions.
* Root Mean Square: The RMS value of the EMG signal provides the equivalent to the DC component of the signal. This could quantify the baseline measure of electrical activity from the EMG.

Following this, a statistical analysis was conducted to determine which metric correlates best with EMG activity.
<img src="https://github.com/user-attachments/assets/5d580d57-5128-415a-ad6c-20bb867a2542" width="400" height="300">
<img src="https://github.com/user-attachments/assets/3511823e-ad4e-48f5-bcca-d151692118f8" width="400" height="158">

Plots of linear regression:

<img src="https://github.com/user-attachments/assets/bee66772-dcef-4cd0-bb4e-2c68329df39e" width="400" height="300">
<img src="https://github.com/user-attachments/assets/8a591462-9b67-493a-8945-ca6963f4adf6" width="400" height="300">
<img src="https://github.com/user-attachments/assets/1358503a-f376-4877-8919-4caba923439d" width="400" height="300">
<img src="https://github.com/user-attachments/assets/3fcd45e9-a7b4-4dcc-a53d-25dca16c3ffe" width="400" height="300">
<img src="https://github.com/user-attachments/assets/07752370-e605-4318-b462-56e2a4f42aa1" width="400" height="300">

