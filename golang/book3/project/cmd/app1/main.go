package app1

type Address struct {
	Street string
	City string
	State string
	PostalCode string
}
type Subscribe struct {
	Rate float64
	Name string
	Active bool
	Address
}

type Employee struct {
	FirstName string
	LastName string
	Email string
	Address
}