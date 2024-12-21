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
