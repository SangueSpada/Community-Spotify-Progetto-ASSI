import { Controller } from "@hotwired/stimulus";
export default class extends Controller{
    connect(){
        console.log("connected")
        const messages= document.getElementById("messages")
        messages.addEventListener("DOMNodeInserted", this.resetScroll)
        this.resetScrollWithoutThreshold(messages)
    }
    disconnect(){
        console.log("disconnected")

    }
    resetScroll() {
        const bottomOfScroll = messages.scrollHeight - messages.clientHeight;
        const upperScrollThreshold = bottomOfScroll - 500;
        // Scroll down if we're not within the threshold
        if (messages.scrollTop > upperScrollThreshold) {
          messages.scrollTop = messages.scrollHeight - messages.clientHeight;
        }
    }
    resetScrollWithoutThreshold(messages) {
        messages.scrollTop = messages.scrollHeight - messages.clientHeight;
    }
}