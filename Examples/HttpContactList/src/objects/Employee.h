/*
 * Employee.h
 *
 *  Created on: 21 Dec 2012
 *      Author: James
 */

#ifndef EMPLOYEE_H_
#define EMPLOYEE_H_

#include <QObject>

class Employee : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName FINAL)
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName FINAL)
    Q_PROPERTY(int employeeNumber READ employeeNumber WRITE setEmployeeNumber
               FINAL)

public:
    Employee(QObject *parent = 0);
    Employee(QString argLastName, QString argFirstName, int argEmployeeNumber);

    QString firstName() const;
    QString lastName() const;
    int employeeNumber() const;

    Q_SLOT void setFirstName(QString newName);
    Q_SLOT void setLastName(QString newName);
    Q_SLOT void setEmployeeNumber(int newNumber);

private:
    QString mFirstName;
    QString mLastName;
    int mEmployeeNumber;
};

#endif /* EMPLOYEE_H_ */
