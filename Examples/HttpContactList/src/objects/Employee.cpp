/*
 * Employee.cpp
 *
 *  Created on: 21 Dec 2012
 *      Author: James
 */

#include "Employee.h"

Employee::Employee(QObject *parent) {
	setParent(parent);
}

Employee::Employee(QString argLastName, QString argFirstName, int argEmployeeNumber) {
	mLastName = argLastName;
	mFirstName = argFirstName;
	mEmployeeNumber = argEmployeeNumber;
}

QString Employee::firstName() const {
	return mFirstName;
}

QString Employee::lastName() const {
	return mLastName;
}

int Employee::employeeNumber() const {
	return mEmployeeNumber;
}

void Employee::setFirstName(QString newName) {
	mFirstName = newName;
}

void Employee::setLastName(QString newName) {
	mLastName = newName;
}

void Employee::setEmployeeNumber(int newNumber) {
	mEmployeeNumber = newNumber;
}
