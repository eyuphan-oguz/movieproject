import 'package:flutter/material.dart';
import 'package:movieproject/core/widgets/button_widget.dart';
import 'package:movieproject/product/constant/category.dart';
import 'package:movieproject/product/constant/padding.dart';
import 'package:movieproject/product/utils/utils.dart';
import 'package:movieproject/product/widgets/textformfield_widget.dart';
import 'package:movieproject/resources/content_method.dart';
import 'package:movieproject/screens/login_page_view.dart';


class PublishContentPageView extends StatefulWidget {
  const PublishContentPageView({super.key});

  @override
  State<PublishContentPageView> createState() => _PublishContentPageViewState();
}
TextEditingController _titleController=TextEditingController();
TextEditingController _descriptionController=TextEditingController();
TextEditingController _directorController=TextEditingController();
TextEditingController _actorController=TextEditingController();
TextEditingController _maturityLevelController=TextEditingController();
TextEditingController _imdbController=TextEditingController();
TextEditingController _releaseDateController=TextEditingController();
TextEditingController _contentImageUrlController=TextEditingController();
bool _isLoading = false;
List<String>actors=[];
class _PublishContentPageViewState extends State<PublishContentPageView> {

String dropdownValue="Aksiyon";


       void publishContent() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await ContentMethod().createContent(
        title: _titleController.text,
        description: _descriptionController.text,
        director: _directorController.text,
        actors: actors,
        maturityLevel: _maturityLevelController.text,
        imdb: _imdbController.text,
        releaseDate: _releaseDateController.text,
        contentImageUrl: _contentImageUrlController.text,
        type: dropdownValue,

       );
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPageView()
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: ProjectPadding().mainPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormFieldWidget(hintText: "İçerik Adı", size: size, icon: Icons.abc_outlined, isPasswordField: false, controller: _titleController, type: TextInputType.text, visible: false),
                TextFormFieldWidget(hintText: "Açıklama", size: size, icon: Icons.abc_outlined, isPasswordField: false, controller: _descriptionController, type: TextInputType.multiline, visible: false,maxLines: 5,),
                TextFormFieldWidget(hintText: "Yönetmen Adı", size: size, icon: Icons.abc_outlined, isPasswordField: false, controller: _directorController, type: TextInputType.name, visible: false),
                TextFormFieldWidget(hintText: "Oyuncu Adı", size: size, icon: Icons.abc_outlined, isPasswordField: false, controller: _actorController, type: TextInputType.name, visible: false),
                ButtonWidget(onPressed: (){
                  setState(() {
                    actors.add(_actorController.text);
                    _actorController.clear();
                  });
                }, buttonText: "Oyuncu Ekle", size: size, backgroundColor: Colors.red),
                //Text(actors.toString(),style: TextStyle(color: Colors.white),),
                actors.length!=[] ? ListView.builder(
                  itemCount: actors.length,
                  shrinkWrap: true,
                  itemBuilder:(context, index) { 
                    return ListTile(
                      leading: Icon(Icons.person,color:Colors.red),
                      title: Text(actors[index] !=null ? actors[index] : "",style:TextStyle(color: Colors.white)),
                      trailing: IconButton(onPressed: (){
                        setState(() {
                          actors.removeAt(index);                    
                        });
                      },icon: Icon(Icons.remove,color: Colors.red,),),
                    );
                  },
                ):Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Tur : ",style: TextStyle(color: Colors.white),),
                    CustomDropdownMenu(),
                  ],
                ),
                TextFormFieldWidget(hintText: "Yaş Sınırı", size: size, icon: Icons.abc_outlined, isPasswordField: false, controller: _maturityLevelController, type: TextInputType.number, visible: false),
                TextFormFieldWidget(hintText: "Imdb Puanı", size: size, icon: Icons.abc_outlined, isPasswordField: false, controller: _imdbController, type: TextInputType.number, visible: false),
                TextFormFieldWidget(hintText: "Yayın Tarihi", size: size, icon: Icons.abc_outlined, isPasswordField: false, controller: _releaseDateController, type: TextInputType.datetime, visible: false),
                TextFormFieldWidget(hintText: "Poster URL", size: size, icon: Icons.abc_outlined, isPasswordField: false, controller: _contentImageUrlController, type: TextInputType.url, visible: false),
                
               !_isLoading ? ButtonWidget(onPressed: publishContent, buttonText: "İçeriği Paylaş", size: size, backgroundColor: Colors.red):
               ButtonWidget(onPressed: (){}, buttonText: "Lütfen Bekleyin", size: size, backgroundColor: Colors.red)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomDropdownMenu(){
    return DropdownButton(
                icon: Icon(Icons.arrow_drop_down_sharp),
                items: categoryList.map<DropdownMenuItem<String>>(
                (String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(color: Colors.grey),),
                  );
                }
               ).toList(), onChanged: (String? value){
                setState(() {
                  dropdownValue=value!;
                });
               },value: dropdownValue,);
  }
}