describe GeekDict::Debugger do
  describe '#debug' do
    # The logger writes to the STDOUT constant, so capture at the process level.
    it 'prints the message when enabled' do
      debugger = GeekDict::Debugger.new true
      expect { debugger.debug 'Test bug' }.to output(/Test bug/).to_stdout_from_any_process
    end

    it 'prints nothing when disabled' do
      debugger = GeekDict::Debugger.new false
      expect { debugger.debug 'Test bug' }.not_to output.to_stdout_from_any_process
    end
  end
end
