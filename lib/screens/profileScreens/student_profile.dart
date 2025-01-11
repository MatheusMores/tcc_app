import 'dart:io';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tcc_app/models/student.dart';

import 'package:tcc_app/screens/components/home/profile_display.dart';
import '../components/global/app_drawer.dart';
import '../components/global/base_app_bar.dart';
import 'package:share_plus/share_plus.dart';

class StudentProfile extends StatelessWidget {
  final Student student;
  StudentProfile(this.student, {super.key});
  // final matricula = "2022154865";
  // final dataNascimento = "10/03/2018";
  // final photo = File(
  //     "C:/Users/needd/OneDrive/Desktop/Programacao/TCC_APP/tcc_app/lib/data/images/boy.jpg");
  // final guardians = [
  //   "Luciana",
  //   "Seu Zé",
  //   "Maria Teresa",
  //   "Seu Juscelino",
  //   "Mariazinha"
  // ];
  // final entrysAndExists = [
  //   "Entrada: 14/11/2024 14:15",
  //   "Saida: 14/11/2024 17:00",
  //   "Entrada: 15/11/2024 14:00",
  //   "Saida: 15/11/2024 17:21",
  //   "Entrada: 16/11/2024 15:00",
  //   "Saida: 16/11/2024 17:05"
  // ];

  void generatingQrCodeAndSaving() {
    final qrcode = PrettyQrView.data(
      data: student.registrationNumber,
      decoration: const PrettyQrDecoration(
        shape: PrettyQrSmoothSymbol(color: Colors.lightBlue),
        image: PrettyQrDecorationImage(
          image: AssetImage('assets/images/MeproviLogoWithoutBg.png'),
        ),
      ),
    );
//     final qrImage = QrImage(qrcode);
//     final qrImageBytes = await qrImage.toImageAsBytes(
//       size: 512,
//       format: ImageByteFormat.png,
//       decoration: const PrettyQrDecoration(),
// );
    // return qrcode;
  }
  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.1;
    final double verticalPadding = MediaQuery.of(context).size.height * 0.05;
    bool entryIsEmpty = student.entries!.isEmpty;
    bool exitIsEmpty = student.exits!.isEmpty;
    bool warningIsEmpty = student.warnings!.isEmpty;
    bool guardiansIsEmpty = student.guardians.isEmpty;
    

    final double horizontalPaddingText =
        MediaQuery.of(context).size.width * 0.1;
    final double verticalPaddingText =
        MediaQuery.of(context).size.height * 0.02;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: const BaseAppBar(screen_title: Text("Student")),
        drawer: AppDrawer(),
        body: DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 1,
          maxChildSize: 1,
          builder: (context, ScrollController) {
            return SingleChildScrollView(
              controller: ScrollController,
              child: Column(
                children: [
                  SizedBox(
                    width: 500,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          
                          vertical: verticalPadding),
                      child: ProfileDisplay(
                          name: student.name,
                          classOrInstitution: student.studentClass!.name),
                    ),
                  ),
                  
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(15), // Bordas arredondadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Cor da sombra
                          spreadRadius: 2, // Distância de expansão da sombra
                          blurRadius: 8, // Nível de desfoque
                          offset: Offset(
                              4, 6), // Deslocamento horizontal e vertical
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: verticalPaddingText),
                          child: SizedBox(
                            width: 500,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPaddingText),
                              child: Text(
                                'Matricula: ${student.registrationNumber}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: verticalPaddingText),
                          child: SizedBox(
                            width: 500,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPaddingText),
                              child: Text(
                                'Data de Nascimento: ${student.birthDate}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          
                          width: 500,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPaddingText),
                            child: Text(
                              "Responsaveis: ",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        guardiansIsEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: verticalPaddingText),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: horizontalPaddingText),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              Colors.lightBlue, // Cor da borda
                                          width: 3, // Largura da borda
                                        ),
                                      ),
                                      height: 200,
                                      child: Text(
                                          "Não há nenhum Responsavel cadastrado"),
                                    )))
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: verticalPaddingText),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPaddingText),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.lightBlue, // Cor da borda
                                        width: 3, // Largura da borda
                                      ),
                                    ),
                                    height: 200,
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                          itemCount: student.guardians.length,
                                          itemBuilder: (ctx, index) {
                                            return Container(
                                              child: ListTile(
                                                onTap: () {},
                                                title: Text(
                                                  student.guardians[index].name,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                        Container(
                          width: 500,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPaddingText),
                            child: Text(
                              "Advertências: ",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        warningIsEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: verticalPaddingText),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPaddingText),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.lightBlue, // Cor da borda
                                        width: 3, // Largura da borda
                                      ),
                                    ),
                                    height: 200,
                                    child: Text(
                                        "Não há nenhuma advertência cadastrada"),
                                  ),
                                ),
                              )
                            :
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: verticalPaddingText),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPaddingText),
                                  child: Container(
                              height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.lightBlue, // Cor da borda
                                        width: 3, // Largura da borda
                                      ),
                                    ),
                              child: Scrollbar(
                                thumbVisibility: true,
                                child: ListView.builder(
                                          itemCount: student.guardians.length,
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                      
                                        child: ListTile(
                                          onTap: () {},
                                          title: Text(
                                                  student
                                                      .warnings![index].reason,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 500,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPaddingText),
                            child: Text(
                              "Entradas: ",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        entryIsEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: verticalPaddingText),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPaddingText),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.lightBlue, // Cor da borda
                                        width: 3, // Largura da borda
                                      ),
                                    ),
                                    height: 200,
                                    child: Text(
                                        "Não há nenhuma entrada cadastrada"),
                                  ),
                                ),
                              )
                            :
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: verticalPaddingText),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPaddingText),
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.lightBlue, // Cor da borda
                                        width: 3, // Largura da borda
                                      ),
                                    ),
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                          itemCount: student.entries!.length,
                                          itemBuilder: (ctx, index) {
                                            return Container(
                                              child: ListTile(
                                                onTap: () {},
                                                title: Text(
                                                  student
                                                      .entries![index].entryAt
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                        Container(
                          width: 500,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPaddingText),
                            child: Text(
                              "Saidas: ",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        exitIsEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: verticalPaddingText),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPaddingText),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.lightBlue, // Cor da borda
                                        width: 3, // Largura da borda
                                      ),
                                    ),
                                    height: 200,
                                    child: Text(
                                        "Não há nenhuma entrada cadastrada"),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: verticalPaddingText),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPaddingText),
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                              Colors.lightBlue, // Cor da borda
                                        width: 3, // Largura da borda
                                      ),
                                    ),
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                          itemCount: student.exits!.length,
                                          itemBuilder: (ctx, index) {
                                            return Container(
                                              child: ListTile(
                                                onTap: () {},
                                                title: Text(
                                                  student.exits![index].exitAt
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                        PrettyQrView.data(
                          data: student.registrationNumber,
                          decoration: const PrettyQrDecoration(
                            shape:
                                PrettyQrSmoothSymbol(color: Colors.lightBlue),
                            image: PrettyQrDecorationImage(
                              image: AssetImage(
                                  'assets/images/MeproviLogoWithoutBg.png'),
                            ),
                          ),
                        ) 
                        
                      ],
                    ),
                  ),
                ],
              ),
            );
          },        
        ),
      ),
    );
  }
}
