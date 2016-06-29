#Exercise: WorkingWithMultipleProcesses-9
Take this scheduler  code and update it to let you run a function that finds the number of times the word "cat" appears in each file in a given directory. Run one server process per file. The function *File.ls!* returns the names of files in a directory, and *File.read!* reads the contents of a file as a binary. Can you write it as a more generalized scheduler?

Run your code on a directory with a reasonable number of files (maybe around 100) so you can experiment with the effects of concurrency.

## Solution
See the [word_count.exs](./word_count.exs) file for the full modules.

For the purposes of testing I generated 100 files with somewhat randomized content. Each file contains 15000 sentences and there is a 25% chance that each sentence contains the word "cat". These files can be generated using the [generate_test_files.py](./generate_test_files.py) script.

Here is the code being run in *iex*:
```
iex> Runner.run

Inspecting the results:
%{"test_files/file028.txt" => 3796, "test_files/file091.txt" => 3792, "test_files/file052.txt" => 3784, "test_files/file075.txt" => 3685, "test_files/file021.txt" => 3760, "test_files/file002.txt" => 3844, "test_files/file093.txt" => 3735, "test_files/file047.txt" => 3732, "test_files/file066.txt" => 3778, "test_files/file058.txt" => 3810, "test_files/file055.txt" => 3823, "test_files/file042.txt" => 3783, "test_files/file083.txt" => 3893, "test_files/file096.txt" => 3732, "test_files/file003.txt" => 3673, "test_files/file067.txt" => 3740, "test_files/file078.txt" => 3826, "test_files/file015.txt" => 3730, "test_files/file097.txt" => 3667, "test_files/file017.txt" => 3668, "test_files/file068.txt" => 3750, "test_files/file088.txt" => 3814, "test_files/file053.txt" => 3781, "test_files/file071.txt" => 3699, "test_files/file098.txt" => 3770, "test_files/file023.txt" => 3765, "test_files/file084.txt" => 3802, "test_files/file010.txt" => 3743, "test_files/file035.txt" => 3676, "test_files/file063.txt" => 3762, "test_files/file050.txt" => 3829, "test_files/file007.txt" => 3696, "test_files/file027.txt" => 3728, "test_files/file072.txt" => 3762, "test_files/file090.txt" => 3854, "test_files/file025.txt" => 3745, "test_files/file056.txt" => 3767, "test_files/file012.txt" => 3787, "test_files/file033.txt" => 3744, "test_files/file001.txt" => 3769, "test_files/file024.txt" => 3786, "test_files/file060.txt" => 3711, "test_files/file032.txt" => 3709, "test_files/file059.txt" => 3735, "test_files/file094.txt" => 3659, "test_files/file077.txt" => 3745, "test_files/file089.txt" => 3675, "test_files/file082.txt" => 3688, "test_files/file040.txt" => 3815, "test_files/file030.txt" => 3799, ...}



 #   time (ms)
 1     239.18
 2     237.31
 3     282.14
 4     239.86
 5     283.02
 6     255.72
 7     243.07
 8     244.58
 9     245.02
10     283.94
```

I'm not surprised that a single process performs pretty much just as well or better than multiple processes given that the VM this is running is only has a single core. I'd like to run this again on my home PC to see the difference.
