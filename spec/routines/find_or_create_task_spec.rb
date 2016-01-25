require 'rails_helper'

RSpec.describe FindOrCreateTask, type: :routine do

  let!(:task) { FactoryGirl.build :task }

  it "finds or creates a record for the given task" do
    saved_task = nil
    expect{ saved_task = described_class.call(task).outputs.task }.to change{ Task.count }.by(1)
    expect(saved_task).to eq task

    expect{ saved_task = described_class.call(task).outputs.task }.not_to change{ Task.count }
    expect(saved_task).to eq task
  end

  it "errors out if the task has validation errors" do
    result = nil

    identifier = task.identifier
    task.identifier = nil
    expect{ result = described_class.call(task) }.not_to change{ Task.count }
    expect(result.errors.first.offending_inputs).to eq :identifier
    expect(result.errors.first.code).to eq :blank

    resource = task.resource
    task.identifier = identifier
    task.resource = nil
    expect{ result = described_class.call(task) }.not_to change{ Task.count }
    expect(result.errors.first.offending_inputs).to eq :resource
    expect(result.errors.first.code).to eq :blank

    task.resource = resource
    task.trial = nil
    expect{ result = described_class.call(task) }.not_to change{ Task.count }
    expect(result.errors.first.offending_inputs).to eq :trial
    expect(result.errors.first.code).to eq :blank
  end

end
