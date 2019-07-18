import React from "react";
import "./index.css";

export default class Banner extends React.Component {
  render() {
    return (
      <div className="flex w-full">
        <h1 className="text-6xl bg-blue-800 w-full text-center text-white">
          Use the sample app to send pdfs to the VA
        </h1>
      </div>
    );
  }
}
