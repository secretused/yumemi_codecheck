import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/data/repository_data.dart';

import '../view_model/main_page_vm.dart';

class DetailPage extends ConsumerWidget {
  final MainPageVM _vm = MainPageVM();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _vm.setRef(ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repository Detail"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < constraints.maxHeight
              ? _buildVertical(context)
              : _buildHorizontal(context);
        },
      ),
    );
  }

  Widget _buildVertical(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // 縦向きの場合
    RepositoryDataItems? data = _vm.tappedRepository;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Image.network(
              data.owner.avatar_url,
              width: size.width * 0.3,
              height: size.width * 0.3,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            data.full_name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            data.language ?? "No Language",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * 0.04,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30.0,
              left: 30.0,
            ),
            child: Text(
              data.description ?? "No Description",
              textAlign: TextAlign.center,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: size.height * 0.02),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          CountText(
              text: "fork数",
              data: data.forks_count.toString(),
              fontsize: size.height * 0.02),
          CountText(
              text: "issue数",
              data: data.open_issues_count.toString(),
              fontsize: size.height * 0.02),
          CountText(
              text: "star数",
              data: data.stargazers_count.toString(),
              fontsize: size.height * 0.02),
          CountText(
              text: "watch数",
              data: data.watchers_count.toString(),
              fontsize: size.height * 0.02),
        ],
      ),
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // 横向きの場合
    RepositoryDataItems? data = _vm.tappedRepository;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Image.network(
              data.owner.avatar_url,
              width: size.height * 0.5,
              height: size.height * 0.5,
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.full_name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                data.language ?? "No Language",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.height * 0.04,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  data.description ?? "No Description",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(fontSize: size.width * 0.02),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                width: size.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CountText(
                        text: "fork数",
                        data: data.forks_count.toString(),
                        fontsize: size.width * 0.02),
                    SizedBox(width: size.width * 0.02),
                    CountText(
                        text: "issue数",
                        data: data.open_issues_count.toString(),
                        fontsize: size.width * 0.02),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CountText(
                        text: "star数",
                        data: data.stargazers_count.toString(),
                        fontsize: size.width * 0.02),
                    SizedBox(width: size.width * 0.02),
                    CountText(
                        text: "watch数",
                        data: data.watchers_count.toString(),
                        fontsize: size.width * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CountText extends StatelessWidget {
  const CountText({
    Key? key,
    required this.text,
    required this.data,
    required this.fontsize,
  }) : super(key: key);

  final String? data;
  final String? text;
  final double? fontsize;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text: $data",
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: fontsize),
    );
  }
}
