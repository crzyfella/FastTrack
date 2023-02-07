using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Business.Utilities.Trendlines
{
    /// <summary>
    /// List of item values
    /// </summary>
    public class ValueList<TValueItem> : System.Collections.ObjectModel.ObservableCollection<TValueItem>
       where TValueItem : IValueItem
    {

        /// <summary>
        /// Raised when items in the value list change or data in existing items change
        /// </summary>
        public event System.EventHandler DataChanged;

        /// <summary>
        /// Type of the items in the list
        /// </summary>
        public ValueListTypes ListType { get; private set; }

        /// <summary>
        /// Default constructor
        /// </summary>
        private ValueList()
        {
            this.CollectionChanged += ValueList_CollectionChanged;
        }

        /// <summary>
        /// Constructor with the list type information
        /// </summary>
        /// <param name="listType"></param>
        internal ValueList(ValueListTypes listType) : this()
        {
            this.ListType = listType;
        }

        /// <summary>
        /// Handles collection changed events for data items
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ValueList_CollectionChanged(object sender, System.Collections.Specialized.NotifyCollectionChangedEventArgs e)
        {
            // Delete PropertyChanged event handlers from items removed from collection
            if (e.OldItems != null)
            {
                foreach (IValueItem item in e.OldItems)
                {
                    item.PropertyChanged -= item_PropertyChanged;
                }
            }
            // Add PropertyChanged event handlers to items inserted into collection
            if (e.NewItems != null)
            {
                foreach (IValueItem item in e.NewItems)
                {
                    item.PropertyChanged += item_PropertyChanged;
                }
            }
            this.NotifyDataChanged(this);
        }

        /// <summary>
        /// Handles Property changed events from individual items in the collection
        /// </summary>
        /// <param name="sender">Item that has changed</param>
        /// <param name="e">Event arguments</param>
        private void item_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            this.NotifyDataChanged(sender);
        }

        /// <summary>
        /// Raises DataChanged event
        /// </summary>
        /// <param name="sender">Item that hsa changed</param>
        private void NotifyDataChanged(object sender)
        {
            System.EventHandler handler = this.DataChanged;

            if (handler != null)
            {
                handler(sender, new System.EventArgs());
            }
        }
    }
}
