#include <iostream>
#include<string>
#include<array>
#define Max_No_Of_Records 100
static int id=0;
class record 
{
    public :
    std::string Name ;
    int age ;
};
std::array<record,Max_No_Of_Records> students_num;

 enum class Option
{
Add_record=1,
fetch_record,
exit
};

void Add_record ()
{
     if (id >= Max_No_Of_Records) {
        std::cout << "Error: Cannot add more records, max limit reached.\n";
        return;
    }
    std::cout<<"enter your name"<<"\n" ;
    std::cin>>students_num[id].Name  ;
    std::cout<<"enter your age"<<"\n" ;
    std::cin>>students_num[id].age  ;
    id++;
}
void fetch_record (int requested_id)
{
    //checking on validity of id
    if(requested_id>id)
    {
std::cout<<"ERROR ::this student is unrecorded"<<"\n" ; 
return;
    }
    if(requested_id>=Max_No_Of_Records)
    {
std::cout<<"ID out of range"<<"\n" ; 
return;
    }
    std::cout<<"user id " << requested_id<<"\n";
    std::cout<<"user name " <<students_num[requested_id].Name <<"\n";
    std::cout<<"user age " <<students_num[requested_id].age <<"\n";
}
void show_options()
{
    std::cout<<"please add an option"<<"\n";
    std::cout<<"1.Add record"<<"\n";
    std::cout<<"2.fetch record"<<"\n";
    std::cout<<"3.quit"<<"\n";
}
int main()
{
    int choice;
int exit_program=0;
int requested_id;
while(!exit_program)
{
 show_options();
std::cout<<"enter option"<<"\n";
std::cin >>choice;
Option option = static_cast<Option>(choice);
switch(option)
{
    case Option::Add_record:
    Add_record();
    break ;
  case Option::fetch_record:
  std::cout<<"enter id"<<"\n";
  std::cin>>requested_id ;
    fetch_record(requested_id);
    break ;
    case Option::exit:
    exit_program=1;
    std::cout<<"exit"<<"\n";
    break;
}
}
}

