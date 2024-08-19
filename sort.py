# Define the file path
file_path = 'out.txt'

# Read the data from the file
with open(file_path, 'r') as file:
    data_entries = file.readlines()

# Function to extract the priority as an integer
def extract_priority(entry):
    # Extract the portion after 'prior = ' and convert it to an integer
    prior_value = entry.split('prior = ')[1].strip()
    return int(prior_value, 16)  # Convert from hex to integer

# Sort the entries based on the extracted priority
sorted_entries = sorted(data_entries, key=extract_priority)

# Write the sorted data back to the file or print it
with open('sorted_data.txt', 'w') as sorted_file:
    sorted_file.writelines(sorted_entries)

# Optional: Print the sorted entries to the console
for entry in sorted_entries:
    print(entry.strip())
