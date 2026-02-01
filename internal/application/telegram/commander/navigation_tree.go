package commander

import (
	"log"
	"os"
	"slices"
	"strings"

	"gopkg.in/yaml.v3"
)

type NavigationTree struct {
	ClientNavigationTree NavigationSection `yaml:"client_navigation_tree"`
}

type NavigationSection struct {
	ID          string              `yaml:"id,omitempty"`
	Name        string              `yaml:"name,omitempty"`
	Description string              `yaml:"description,omitempty"`
	Warning     string              `yaml:"warning,omitempty"`
	Sections    []NavigationSection `yaml:"sections,omitempty"`
}

func LoadNavigationTree(filePath string) *NavigationTree {
	yamlData, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatal(err)
	}

	var tree NavigationTree
	err = yaml.Unmarshal(yamlData, &tree)
	if err != nil {
		log.Fatalf("Unmarshal failed: %v", err)
		return nil
	}
	return &tree
}

func (t *NavigationTree) GetSectionByPath(path string) *NavigationSection {
	val, err := t.getSectionByPath(t.ClientNavigationTree.Sections, path)
	if err != nil {
		log.Fatalf("GetSectionByPath failed: %v", err)
		return nil
	}
	return val
}

func (t *NavigationTree) getSectionByPath(sections []NavigationSection, path string) (*NavigationSection, error) {
	pathKeys := strings.Split(path, ".")
	pathKeysRest := slices.Delete(slices.Clone(pathKeys), 0, 1) // we delete it from unsafePathSlice

	var s *NavigationSection
	for _, section := range sections {
		if section.ID == pathKeys[0] {
			if len(pathKeysRest) > 0 {
				s, _ = t.getSectionByPath(section.Sections, strings.Join(pathKeysRest, "."))
				break
			}
			s = &section
			break
		}
	}
	return s, nil
}
