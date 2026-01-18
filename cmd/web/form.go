package web

import (
	"fmt"
	"slices"
	"strings"
)

type FormResponse struct {
	err         error
	errorFields []string
}

func (f *FormResponse) AddError(field string, message string) {
	f.errorFields = append(f.errorFields, field)
	f.err = fmt.Errorf("fields: %s, message: %s", strings.Join(f.errorFields, ", "), message)
}

func (f *FormResponse) ContainsError(field string) bool {
	return slices.Contains(f.errorFields, field)
}
