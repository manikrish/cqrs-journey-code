﻿// ==============================================================================================================
// Microsoft patterns & practices
// CQRS Journey project
// ==============================================================================================================
// ©2012 Microsoft. All rights reserved. Certain content used with permission from contributors
// http://cqrsjourney.github.com/contributors/members
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance 
// with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software distributed under the License is 
// distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
// See the License for the specific language governing permissions and limitations under the License.
// ==============================================================================================================

namespace Azure.Tests
{
    using System;
    using Azure.Messaging;
    using Common;
    using Moq;
    using Xunit;

    public class CommandProcessorFixture
    {
        [Fact]
        public void when_disposing_processor_then_disposes_receiver_if_disposable()
        {
            var receiver = new Mock<IMessageReceiver>();
            var disposable = receiver.As<IDisposable>();

            var processor = new CommandProcessor(receiver.Object, Mock.Of<ISerializer>());

            processor.Dispose();

            disposable.Verify(x => x.Dispose());
        }

        [Fact]
        public void when_disposing_processor_then_no_op_if_receiver_not_disposable()
        {
            var processor = new CommandProcessor(Mock.Of<IMessageReceiver>(), Mock.Of<ISerializer>());

            processor.Dispose();
        }

        [Fact]
        public void when_handler_already_registered_for_command_then_throws()
        {
            var processor = new CommandProcessor(Mock.Of<IMessageReceiver>(), Mock.Of<ISerializer>());
            var handler1 = Mock.Of<ICommandHandler<FooCommand>>();
            var handler2 = Mock.Of<ICommandHandler<FooCommand>>();

            processor.Register(handler1);

            Assert.Throws<ArgumentException>(() => processor.Register(handler2));
        }

        public class FooCommand : ICommand
        {
            public Guid Id { get; set; }
        }

    }
}
