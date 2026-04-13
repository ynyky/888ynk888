package datafile

import (
	"bufio"
	"os"
)

func GetStrings(fileName string) ([]string, error) {
	var lines []string

	file, err := os.Open(fileName)
	if err != nil {
		return nil, err
	}
	defer file.Close() // ✅ Use defer for cleaner resource management

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		lines = append(lines, line)
	}

	if err := scanner.Err(); err != nil {
		return nil, err
	}

	return lines, nil
}
