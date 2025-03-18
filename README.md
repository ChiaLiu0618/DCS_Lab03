
\documentclass{article}
\usepackage[a4paper,margin=1in]{geometry}
\usepackage{hyperref}

\title{Digital Circuit and System - Lab03: FSM-based AutoPay System}
\author{Institute of Electronics, NYCU \newline NYCU CERES LAB}
\date{March 20, 2025}

\begin{document}

\maketitle

\section{Introduction}
Finite State Machines (FSMs) are crucial for designing sequential circuits, controlling the flow of operations based on inputs, and managing states effectively. This lab focuses on FSM modeling by implementing an AutoPay system that simulates credit card transactions.

\section{Finite State Machine (FSM) Overview}
\begin{itemize}
    \item FSMs can be classified into two types:
    \begin{itemize}
        \item \textbf{Mealy Machine}: Output depends on the current state and input signals, requiring fewer states but more hardware.
        \item \textbf{Moore Machine}: Output depends solely on the current state, making it safer but requiring more states.
    \end{itemize}
    \item FSMs transition between states based on input conditions and control signals.
    \item Proper FSM design separates current state, next state, and output logic.
\end{itemize}

\section{Project Description}
The goal of this project is to design an FSM-based AutoPay system for credit card transactions. The system performs the following operations:
\begin{itemize}
    \item Receives an initial credit balance.
    \item Processes three purchases, each delayed by 2--4 clock cycles.
    \item Deducts each item's price from the balance.
    \item If the balance is insufficient during any transaction, it outputs a warning signal (\texttt{9'b1\_0000\_0000}) and terminates further processing.
    \item Ensures proper synchronization and adheres to timing constraints.
\end{itemize}

\section{Input and Output Signals}
\subsection{Input Signals}
\begin{tabular}{|c|c|l|}
    \hline
    \textbf{Signal} & \textbf{Bit Width} & \textbf{Description} \\
    \hline
    clk & 1 & Clock signal \\
    rst\_n & 1 & Asynchronous active-low reset \\
    credit\_valid & 1 & High when credit input is valid \\
    credit & 8 & Initial credit balance \\
    price\_valid & 1 & High when price input is valid \\
    price & 6 & Current item's price \\
    \hline
\end{tabular}

\subsection{Output Signals}
\begin{tabular}{|c|c|l|}
    \hline
    \textbf{Signal} & \textbf{Bit Width} & \textbf{Description} \\
    \hline
    out\_valid & 1 & High when output data is valid \\
    out\_data & 9 & Remaining balance after transactions or warning signal \\
    \hline
\end{tabular}

\section{Implementation Details}
\begin{itemize}
    \item The system uses an asynchronous active-low reset.
    \item The reset signal is applied once at the beginning of the simulation.
    \item All outputs synchronize with the positive clock edge.
    \item \texttt{out\_valid} should never overlap with \texttt{in\_valid}.
    \item No latches are allowed in the synthesized design.
    \item The design should meet all timing constraints without violations.
\end{itemize}

\section{Simulation and Testing}
The project includes multiple verification steps:
\begin{itemize}
    \item \textbf{RTL Simulation}: The RTL simulation is performed using Synopsys VCS.
    \item \textbf{Synthesis}: The design is synthesized using Synopsys Design Compiler with TSMC 40nm technology.
    \item \textbf{Gate-Level Simulation}: The synthesized design is simulated using Synopsys VCS.
    \item \textbf{Waveform Debugging}: Synopsys Verdi is used to inspect signals and debug the design.
\end{itemize}

\end{document}
