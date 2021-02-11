This voice recognition app is a project made for 2020 digital signal processing class by Vilnius Gediminas Technical University students:
* Gleb Čirkov (voice recognition algorithm logic, documentation, testing)
* Maksim Igošev (idea author, GUI code, testing)
* Osmundas Marcinkonis (voice recognition algorithm logic and code, documentation)

---
To use the app, you will need:
* MATLAB R2020a
* VOICEBOX Speech Processing Toolbox for MATLAB: https://github.com/ImperialCollegeLondon/sap-voicebox
* A microphone

Required VOICEBOX functions:
* v_distisar.m
* v_findpeaks.m
* v_lpcar2ra.m
* v_lpcar2rf.m
* v_lpcar2rr.m
* v_lpcauto.m
* v_lpcrf2rr.m
* v_windinfo.m
* v_windows.m

For the sake of simplicity, you may extract the whole VOICEBOX library into the folder you choose to save this app in.

---
Usage:
1. Run app.m in order to start the app.
2. On the first launch, click "Record Samples"
3. The app will ask you to record 3 spells from the book series Harry Potter. On prompt, pronounce the spells one by one into your microphone. Repeat when you are asked to.
4. Click "Cast a spell" and the app will recognise whether your spell matches the samples or not. The color of the text output provided by the app represents spell colors in Harry Potter movies.

Note: not only does the app recognise whether the provided phrases match. It also recognises whether the users pronouncing the spells are the same people who recorded the samples. This is intended as a feature for a potential wizard fight game which could be developed in the future. For this reason, pre-recorded samples cannot be provided with the app (the samples must be personalised for each user).

---
Documentation:
* Extensive documentation is available in Lithuanian.
* If you are not a Lithuanian speaker who would like to learn more about this project, feel free to contact me - osmundas.m@gmail.com