import os, random

# Global variables.
sentences = [
    'The cow jumped over the moon.',
    'The cat in the hat laid on the mat.',
    'This little piggy went to the market.',
    'It\'s a piece of cake to bake a pretty cake.'
]
file_count = 100;
sentence_count = 15000;
file_name_prefix = 'file';
file_name_suffix = '.txt';
output_directory = 'test_files';

def main():
    os.makedirs(output_directory)

    for file_index in range(0, file_count):
        file_name = '{0}{1:03d}{2}'.format(file_name_prefix, file_index, file_name_suffix)
        file_path = os.path.join(output_directory, file_name)

        random.seed()
        with open(file_path, 'w+') as test_file:
            for x in range(0, sentence_count):
                sentence_index = random.randint(0, 3)
                test_file.write('{0}{1}'.format(sentences[sentence_index], '\n'))

if __name__ == "__main__":
    main()
