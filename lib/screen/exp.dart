/*@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Main content with profile & basic info
        SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderSection(), // your existing header & info UI
              _buildTabSection(), // tabs like "Basic Info"
            ],
          ),
        ),

        // Overlay popup (shown when showMenu == true)
        if (showMenu)
          Positioned(
            top: 70,
            right: 15,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.block, color: Colors.red),
                      title: Text("Block"),
                      onTap: () {
                        setState(() {
                          showMenu = false;
                        });
                        print("User blocked");
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.report, color: Colors.orange),
                      title: Text("Report"),
                      onTap: () {
                        setState(() {
                          showMenu = false;
                        });
                        print("User reported");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}*/
