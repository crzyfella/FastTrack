using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Business.Utilities.Trendlines
{
    /// <summary>
    /// Linear trend calculation
    /// </summary>
    public class LinearTrend<TValueItem> where TValueItem : IValueItem
    {

        /// <summary>
        /// Has the trend been calculated
        /// </summary>
        public bool Calculated { get; private set; }

        /// <summary>
        /// Slope
        /// </summary>
        public double? Slope { get; private set; }

        /// <summary>
        /// Intercept
        /// </summary>
        public double? Intercept { get; private set; }

        /// <summary>
        /// Correlation coefficient
        /// </summary>
        public double? Correllation { get; private set; }

        /// <summary>
        /// R-squared value
        /// </summary>
        public double? R2 { get; private set; }

        /// <summary>
        /// Data items
        /// </summary>
        public readonly ValueList<TValueItem> DataItems;

        /// <summary>
        /// Trend items
        /// </summary>
        public readonly ValueList<TValueItem> TrendItems;

        /// <summary>
        /// Value for the first trend point on X axis
        /// </summary>
        public TValueItem StartPoint
        {
            get
            {
                TValueItem startItem;

                if (!this.Calculated)
                {
                    return default(TValueItem);
                }

                startItem = this.TrendItems.OrderBy(item => item.ConvertedX).FirstOrDefault();

                return (TValueItem)startItem.CreateCopy(); ;
            }
        }

        /// <summary>
        /// Value for the last trend point on X axis
        /// </summary>
        public TValueItem EndPoint
        {
            get
            {
                TValueItem endItem;

                if (!this.Calculated)
                {
                    return default(TValueItem);
                }

                endItem = this.TrendItems.OrderByDescending(item => item.ConvertedX).FirstOrDefault();

                return (TValueItem)endItem.CreateCopy(); ;
            }
        }

        /// <summary>
        /// Default constructor
        /// </summary>
        public LinearTrend()
        {
            this.DataItems = new ValueList<TValueItem>(ValueListTypes.DataItems);
            this.TrendItems = new ValueList<TValueItem>(ValueListTypes.TrendItems);
            this.Calculated = false;
            this.DataItems.DataChanged += DataItems_DataChanged;
        }

        /// <summary>
        /// Handles DataChanged event from the data item collection
        /// </summary>
        /// <param name="sender">Item that has changed</param>
        /// <param name="e"></param>
        private void DataItems_DataChanged(object sender, System.EventArgs e)
        {
            if (this.Calculated)
            {
                this.Calculated = false;
                this.Slope = null;
                this.Intercept = null;
                this.Correllation = null;
                this.TrendItems.Clear();
            }
        }

        /// <summary>
        /// Calculates the trendline
        /// </summary>
        /// <returns>True if succesful</returns>
        public bool Calculate()
        {
            double slopeNumerator;
            double slopeDenominator;
            double correlDenominator;
            double r2Numerator;
            double r2Denominator;
            double averageX;
            double averageY;
            TValueItem trendItem;

            if (this.DataItems.Count == 0)
            {
                return false;
            }

            // Calculate slope
            averageX = this.DataItems.Average(item => item.ConvertedX);
            averageY = this.DataItems.Average(item => item.Y);
            slopeNumerator = this.DataItems.Sum(item => (item.ConvertedX - averageX) * (item.Y - averageY));
            slopeDenominator = this.DataItems.Sum(item => System.Math.Pow(item.ConvertedX - averageX, 2));

            this.Slope = slopeNumerator / slopeDenominator;

            // Calculate Intercept
            this.Intercept = averageY - this.Slope * averageX;

            // Calculate correlation
            correlDenominator = System.Math.Sqrt(this.DataItems.Sum(item => System.Math.Pow(item.ConvertedX - averageX, 2)) * this.DataItems.Sum(item => System.Math.Pow(item.Y - averageY, 2)));
            this.Correllation = slopeNumerator / correlDenominator;

            // Calculate trend points
            foreach (TValueItem item in this.DataItems.OrderBy(dataItem => dataItem.ConvertedX))
            {
                if (this.TrendItems.Where(existingItem => existingItem.ConvertedX == item.ConvertedX).FirstOrDefault() == null)
                {

                    trendItem = (TValueItem)item.NewTrendItem();
                    trendItem.ConvertedX = item.ConvertedX;
                    trendItem.Y = this.Slope.Value * item.ConvertedX + this.Intercept.Value;
                    this.TrendItems.Add(trendItem);
                }
            }

            // Calculate r-squared value
            r2Numerator = this.DataItems.Sum(
               dataItem => System.Math.Pow(dataItem.Y
               - this.TrendItems.Where(
                  calcItem => calcItem.ConvertedX == dataItem.ConvertedX).First().Y, 2));

            r2Denominator = this.DataItems.Sum(dataItem => System.Math.Pow(dataItem.Y, 2))
               - (System.Math.Pow(this.DataItems.Sum(dataItem => dataItem.Y), 2) / this.DataItems.Count);

            this.R2 = 1 - (r2Numerator / r2Denominator);

            this.Calculated = true;

            return true;
        }
    }
}
