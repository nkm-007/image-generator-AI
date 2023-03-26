import 'package:flutter/material.dart';

import 'api_Services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sizes=["Small","Medium","Large"];
  var values=["256x256","512x512","1024x1024"];
   String? dropValues;
   var textController=TextEditingController();
   String image='';
   var isLoaded=false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Welcome to NKM/AI',
        )
        ,
        leading: Container(
          child:const CircleAvatar(
            backgroundImage:AssetImage('assets/gngqevxv.png') ,
          ),
        ),
      ),
      body: Padding(
      padding: const EdgeInsets.all(8.0),
      child:Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TextFormField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your text',
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    ),
                    const SizedBox(width: 12),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child:DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: const Icon(Icons.expand_more,color: Colors.black38),
                        value: dropValues,
                        hint: const Text("Select Size"),
                          items: List.generate(
                              sizes.length,
                                  (index) => DropdownMenuItem(
                                    value: values[index],
                                      child:Text(sizes[index]) )),
                          onChanged: (value) {
                          setState(() {
                            dropValues=value.toString();
                          });
                          },
                      ),
                    ),
                  ),
                  ],
                ),
                Flexible(
                  child: SizedBox(
                    height: 40,
                    width: 350,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: const StadiumBorder()
                      ),
                        onPressed: () async {
                        if(textController.text.isNotEmpty && dropValues!=null){
                          setState((){
                            isLoaded=false;
                          });
                          image= await Api.generateImage(textController.text,dropValues!);
                          setState(() {
                            isLoaded=true;
                          });
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please query and size both")),
                          );
                        }


                        },
                        child: const Text("Generate")
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
              child: isLoaded ?
              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.network(image,
                    fit: BoxFit.contain),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                              child:ElevatedButton.icon(onPressed: (){},
                                  icon: const Icon(Icons.download_for_offline_rounded),
                                  label: const Text("Download")) ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(onPressed: (){},
                          icon: const Icon(Icons.share),
                          label: const Text("Share") ),
                        ],
                      ),
                    ],
                ),
              )
                  :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset("assets/loader.gif"),
                      Image.network('https://media.tenor.com/UnFx-k_lSckAAAAM/amalie-steiness.gif'),
                      const SizedBox(height: 12),
                      const Text(
                          "Waiting for your input",
                        style: TextStyle(
                          color: Colors.white
                        ),

                      )
                    ],
                  ),
          ),

        ],
      ),
    ));
  }
}
