INCLUDE_PATH=source
SOURCE_PATH=source
TARGET_PATH=bin

EXECUTE_FILE=$(TARGET_PATH)/main
SFML_CFLAGS=-l sfml-system -l sfml-window -l sfml-graphics -l sfml-audio
TINYXMLFLAGS=-l tinyxml2
all:
	mkdir -p $(TARGET_PATH)
	cp -r res $(TARGET_PATH)
	g++ -o $(EXECUTE_FILE) $(SOURCE_PATH)/*.cpp -I $(INCLUDE_PATH) $(SFML_CFLAGS) $(TINYXMLFLAGS)
clean:
	rm -rf $(TARGET_PATH)
